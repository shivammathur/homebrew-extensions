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
    rebuild 14
    sha256 arm64_big_sur: "a652921c1f1048a4dd19eda8668f758ff7e7458cd838f967084d2fc632ee194f"
    sha256 big_sur:       "17fe40ae9143150f8b75674344dc29a8ec56bc356f9e6ae8fc96542d5dc1782f"
    sha256 catalina:      "9d29b013a4f80b4db9849bb7986bd844a4e3f047403e7340b38db71a76b610c8"
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
