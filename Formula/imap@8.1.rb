# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=ae8647d9d3fa420e1116af02ac431772f81c9968"
  version "8.1.0"
  sha256 "334168111197a7c1c9d422cf25ef0f65d58d0c0e026075534a7f4e627b84160c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 arm64_big_sur: "d98e062698a6492b8f30a66a5e58662f716cc61d4cd2121d26a60029983a88d0"
    sha256 big_sur:       "9526972b5d70665aa1d7fd25df3b8201bc8b4d2f6106283b2c447d8e6f82f63b"
    sha256 catalina:      "c5b069e9f73d1869a79f9d5f700ac626cc8518081325985fed0325165ca9ec77"
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
