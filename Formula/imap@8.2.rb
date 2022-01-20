# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/262d4c220bc85cdbd0005d02d7a29a4c1dac8a12.tar.gz?commit=262d4c220bc85cdbd0005d02d7a29a4c1dac8a12"
  version "8.2.0"
  sha256 "657a3f5caaaf51e925e5b82e29a0f205cabe8715acd2d89cdb40e2c2d0a455b4"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 29
    sha256 cellar: :any,                 arm64_big_sur: "8b29200abfd257493ea63ae2e67fa7f13cc386dd715674b59928134a82d775dd"
    sha256 cellar: :any,                 big_sur:       "18d979a5589e81db564cefb527d7c590cfb92bc91563773e5d1b6a6a5dc6674b"
    sha256 cellar: :any,                 catalina:      "d0ad06be5f54e016044ae84930c4db093ff585f5dbdc30a8dba3ea0b88680f5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef590358193a7dc6db785e5f0cd10b679516e030b2d52c6207ab4bcb202ef495"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

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
