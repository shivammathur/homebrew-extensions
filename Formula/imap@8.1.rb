# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=7e9f6d2a48f8ff6ae458252d395eec1b1d9e6f14"
  version "8.1.0"
  sha256 "f3a3a86b4dfe0fcff6c2a381b5b1362aaa58d26cf07fa9237637d9b51f4f897e"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 30
    sha256 arm64_big_sur: "a8bb49a681f3cba8394dd3135fad24c39400cde9ce98c6c2b79de95d19722cab"
    sha256 big_sur:       "f6d81ee3cd6e6f2483f7b205dba068ccec4c3f604d8d7a4deb443162ecd5ac0c"
    sha256 catalina:      "ecc37ea39921f0bf41515f306cd82878ad184bb80a3ac224fd9ce5b34eb7d757"
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
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
