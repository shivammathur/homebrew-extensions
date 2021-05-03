# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.5.tar.xz"
  sha256 "5dd358b35ecd5890a4f09fb68035a72fe6b45d3ead6999ea95981a107fd1f2ab"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "82e35a1ffc561cffaf51852338abee80733b68214f46c722b7615082445e79a4"
    sha256 big_sur:       "d49f082dd14a59f3fa01031d03d730ec17349c5b3ea65af3fac643f5f64b8356"
    sha256 catalina:      "ecc9a4c089e07d82616511791d3ab08d01078cc396b8e58af509e11b5eea09d6"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
