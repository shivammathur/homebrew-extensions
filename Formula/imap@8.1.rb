# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ff8e04ac30bcdf5023f05f7a39a9d6e5a49558e3.tar.gz?commit=ff8e04ac30bcdf5023f05f7a39a9d6e5a49558e3"
  version "8.1.0"
  sha256 "d4a35be5522ed7707f64de0722c5d5b1102d63248529054af0b17c8c617254b8"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 arm64_big_sur: "a3bd5ab667fb52680c46333b3b045ea568fc3e93635cad31a8b1d0440622e90d"
    sha256 big_sur:       "ae7fa60e5b4ce6fa2538050801744faece5296316ed6cb9620820f75c8f29242"
    sha256 catalina:      "e6b9bafceec2264154d22380449eb15bd06c3ae824bac071790293d88b178d9b"
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
