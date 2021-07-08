# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=bc39abe8c3c492e29bc5d60ca58442040bbf063b"
  version "8.1.0"
  sha256 "423ffdd498dd2009863b76f450bd26235b58f38d8aff2db1c6c44b5caa0ab74b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 arm64_big_sur: "7b188fb83b5c276382de67574419e00d3a3a410af784c56ba25f977f6d0f935c"
    sha256 big_sur:       "7282c0aac1b539cffe44c697875ca7f34fcd9a4443780a1ceaa457956d402287"
    sha256 catalina:      "f47daff101432d1c46b915bf454f55e69f4e64d044e89392ff22b3895f2f47ba"
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
