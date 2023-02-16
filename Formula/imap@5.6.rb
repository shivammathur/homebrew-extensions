# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e4e699e81f4c427582691bd0dae25f3539c3e65e.tar.gz"
  version "5.6.40"
  sha256 "95e65b163387e14ab72071e5f4676b8178298e69c4fac7eb37970dfa78daeb20"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_monterey: "332695f369888dce0c4780f06b154a7777ac4c0b087a1ff58ea1398f06480a27"
    sha256 cellar: :any,                 arm64_big_sur:  "a19b8f2b919c735cb4d7c82975ebec6ed6d8342878952b03b8fe1564460d62bc"
    sha256 cellar: :any,                 monterey:       "bc2b66ed4ea54745bdc2aa612086c3ab2368d6991b440e9243e7be6169bf899b"
    sha256 cellar: :any,                 big_sur:        "9a0c6dd1fbfac38b5e391a9182698f5d26d7d2fe3f9870be1da42a69e4977f53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9810c7ad53b227bb4837024cf7b11fc62f00f7edfaff885537be92116944d36c"
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
