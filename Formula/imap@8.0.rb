# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.7.tar.xz"
  sha256 "d5fc2e4fc780a32404d88c360e3e0009bc725d936459668e9c2ac992f2d83654"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "147ddc3cb70073889071d895274b1b933736ad1af71cc4893e14e8d56c04e505"
    sha256 big_sur:       "1590c87551ee5aa2a068babb048d4de5bd424ccc71d61d34cf7f0aace6eefab2"
    sha256 catalina:      "17c9df8f863d0dc4ff327547a92fb768f8246b6bb79b2e83e272ab15db3c920d"
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
