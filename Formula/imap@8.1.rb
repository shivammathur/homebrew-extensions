# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=0d6358f2cfd03fc06a7765c8e2c97cbae583f4ac"
  version "8.1.0"
  sha256 "74b1b34817d7cc6c3c1853bd95b5943eca0c9a3bfe15dcbb6e34550216a94c66"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 arm64_big_sur: "ab1e1f392747aa6b74686b5f2f3721e5fe7993c5aa3b5f94deaa014dd84120d8"
    sha256 big_sur:       "411761eb5332ae9676138f8b5cb958e4ce281308f8c622455bd90d62650326bc"
    sha256 catalina:      "8f1a0acc36d7d73773fb9d05d5adf88b7c6d550bf424dd5cb14e3965fe06c570"
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
