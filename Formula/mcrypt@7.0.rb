# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/01620e1ea421be6f10360fefc1127e96a9c80467.tar.gz"
  version "7.0.33"
  sha256 "6f801b4bea2dc7025bb09144eb2c63493ab3013c7010d069d8464e88528d29a3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "df6aad7586be369d01b7d5dd1336a60b85c53bd500c2195958ac56dd08494cb6"
    sha256 cellar: :any,                 arm64_big_sur:  "d0c789e480b969acf897ba7dcdb6ec87e06add7b2ec2eeb4da39f69cd486e0af"
    sha256 cellar: :any,                 ventura:        "087fc90dcc30712853d4f9185c67825423c1d057f144fc6a2df6c323aa5a7051"
    sha256 cellar: :any,                 monterey:       "d49b8dfd71f4e1f290dc13ebd067967e3c6168542ff347f711b035bdd5724f6d"
    sha256 cellar: :any,                 big_sur:        "68ef497d25f6526fc34cf29ed9ecd7f984381efdba8fa34970762366ee39bbf7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aa2cad89413d5e2551de28e2e1e0df080310396553f9ad41e9cb6829727d9711"
  end

  depends_on "automake" => :build
  depends_on "libtool"

  resource "libmcrypt" do
    url "https://downloads.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz"
    sha256 "e4eb6c074bbab168ac47b947c195ff8cef9d51a211cdd18ca9c9ef34d27a373e"
  end

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    resource("libmcrypt").stage do
      # Workaround for ancient config files not recognising aarch64 macos.
      %w[config.guess config.sub].each do |fn|
        cp "#{Formula["automake"].opt_prefix}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}", fn
      end

      # Avoid flat_namespace usage on macOS
      inreplace "./configure", "${wl}-flat_namespace ${wl}-undefined ${wl}suppress", "" if OS.mac?

      system "./configure", "--prefix=#{prefix}",
                            "--mandir=#{man}"
      system "make", "install"
    end

    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
