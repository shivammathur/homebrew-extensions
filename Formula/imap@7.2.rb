# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/fc84c778aa61f1eef337532f2b838413bf1ed651.tar.gz"
  version "7.2.34"
  sha256 "fe78092a1bbdff097396fc9e80c34f26bcd7d58d427ed99de7dd06b35d8cd94c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_monterey: "a6d5ff638181b71999354c82b6d5eb59b2a4372415f9c15963a2073138a3ab63"
    sha256 cellar: :any,                 arm64_big_sur:  "266ca894f51a7eef968171b4b33dfe3ea88a607fc0918d233aa14a72d758f328"
    sha256 cellar: :any,                 monterey:       "32abaf96aceac55a33542f6b46f65c14242b26ec1fbfa1074b2fe405961cb51d"
    sha256 cellar: :any,                 big_sur:        "0997f71fb59595ca70d5f27dd6d20f2d970c2932ac0dab27f0cddb3e63f3657e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d32b2aaa6d59d1cf3d3b006a6e7831f71754cb35145dded1a383caa19c5040f4"
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
