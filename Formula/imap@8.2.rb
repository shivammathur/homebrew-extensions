# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/11cedf450d7e578b817c2165a55d048b02bc9923.tar.gz?commit=11cedf450d7e578b817c2165a55d048b02bc9923"
  version "8.2.0"
  sha256 "0b1127005a8a57dfb58c560d7d777270c6ee4a233896d51549329afcfceeab51"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 37
    sha256 cellar: :any,                 arm64_big_sur: "dca3b6a0488093900302191f457e76847dedb96f059990d4aee0f9ceed2a4ca1"
    sha256 cellar: :any,                 big_sur:       "6c71679128bfb357f5f1f76ca03326737868bda9b4287e4b8d4b00f6203d6700"
    sha256 cellar: :any,                 catalina:      "2f8d3f9f250729e0d5f753ecb037749ec8ac477746ad17e2d11dd7795b2545b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eabecc21821278a42bb11f685f3dd9252453da7e9aff8f739bc889228072f9b7"
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
