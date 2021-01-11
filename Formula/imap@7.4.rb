# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhp74Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.14.tar.xz"
  sha256 "f9f3c37969fcd9006c1dbb1dd76ab53f28c698a1646fa2dde8547c3f45e02886"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "2fb4cce828be6949481da32d460c0ece219c7f14d5f8bc0558a0ca29648d94fb" => :arm64_big_sur
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
    prefix.install "modules/imap.so"
    write_config_file
  end
end
