# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/25fce28ca29c7bea677695e50c5ed52139122d20.tar.gz"
  version "5.6.40"
  sha256 "779061ac26e633a1fd52317531a8473bf89872408540ee708d8e3fa285a89538"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    manifest_sha256 "4b7d68bdaf1c367539c5a8e5fc987ad14813aec2359d1e43e6d67ec469593b63"
    sha256 cellar: :any, arm64_golden_gate: "beaaa4ed6756855922e342cc7e8f03c673d6577ea0153335a6e647423da459c5"
    sha256 cellar: :any, arm64_tahoe:       "495353695ec54b5cf32cd7263ba2e0a7891a4d1962d47226b90b389f301f56e5"
    sha256 cellar: :any, arm64_sequoia:     "82389c0e169ca5f7f26b94d018e27fad155508e016438431378701620f37b436"
    sha256 cellar: :any, arm64_linux:       "69e718aabe364951104dc12b0e89220d7942841497eb501ef220b2b0b490871f"
    sha256 cellar: :any, x86_64_linux:      "20963197573e91f5e1cf5f710a6a0146dbcb316c13943146803f9482bdc17ce3"
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
    ENV.append "CFLAGS", "-Wno-implicit-int"

    resource("libmcrypt").stage do
      # Workaround for ancient config files not recognising aarch64 macos.
      automake_version = Formula["automake"].version.major_minor
      %w[config.guess config.sub].each do |fn|
        cp "#{Utils::Path.formula_opt_prefix("automake")}/share/automake-#{automake_version}/#{fn}", fn
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
           "--prefix=#{prefix}",
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
