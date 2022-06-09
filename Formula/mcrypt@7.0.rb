# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7ed6a1d768f60080369d9372b500e0d1f99c57a4.tar.gz"
  version "7.0.33"
  sha256 "3c918b19564c25b000dbd42f1ade5c82ffb7d3e721cb97606f43cbb13ef1cdd5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "8f48249dcb9f57c550590180faf90a042b50cafdb973c0e2a79842c41e77ad4b"
    sha256 cellar: :any,                 arm64_big_sur:  "6d3bdacaab0d7d7144c9243931b1307ce068c4926f9422fcfdf1febfb2279ff6"
    sha256 cellar: :any,                 monterey:       "644cdbe60bfef482f6278cd376ed4ae6fb3c97a154a08d51b7273a47a921a807"
    sha256 cellar: :any,                 big_sur:        "687c69533d264cd5512df2e750d0b3fd7a168b904cef3898b7b538909a5e145f"
    sha256 cellar: :any,                 catalina:       "eed9bfd6c7521b68927382b153515c31e2bf2fae9fca7d72ed7ad6e3fb62564c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ba72cc9f01ec47f006322dd2eb5677b80eff95bf8efafd74d1b468a972a90abf"
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
