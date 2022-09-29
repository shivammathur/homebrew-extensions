# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/63e20a2b1e62df7b5c1b6f4681944c767244299c.tar.gz"
  version "7.1.33"
  sha256 "74e61b77ee695dee97e8b4a5a3e24d106cfdb0fd0bd8bbecb34c0593a799b757"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "12f3a09af3c1a09efa2c0def39392b38d5e0de3faeb57699e9adb17d4b491264"
    sha256 cellar: :any,                 arm64_big_sur:  "bf4fb926801a1d3c1ccbc1ac83f4d8f6029e752d015dce468a8a67d89d04692d"
    sha256 cellar: :any,                 monterey:       "e9fb50209953ad9a77044d363e6f2b3b336a1c8e17bdd2a5865e002ad2715850"
    sha256 cellar: :any,                 big_sur:        "4a186288f2ddffc54d03d7845f6a3f30a6447162f24a5b9bab85f104de33a2dc"
    sha256 cellar: :any,                 catalina:       "bb22469de13aa91f8a9e85f940ce377cb0d0de40d09000658ef45e580a709d17"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b0f6571e1301b45a8bc9a038abd9d18d4f666b35988757b6b8c426d07306c2d1"
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
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
