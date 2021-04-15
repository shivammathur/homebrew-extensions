# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=14fd14d780dbaa6e2f3298bd608eba9270772ce6"
  version "8.1.0"
  sha256 "135c1321b4082c64157a8cbc7e131925b7890e2366976e364f3d746511b527fa"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 34
    sha256 arm64_big_sur: "13eead61e8561ad36f1f0e6500f784d2ba5a68a74d43abcdcb04591b3ba11e89"
    sha256 big_sur:       "c28e7138accd458a724110a17a44f66a7f7017a73ecf970a751c587b8471b7b5"
    sha256 catalina:      "5f9d70ed5fb10df173e116d8b017807d3d268f5d5f36f89e8fe2b15ee52521e0"
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
