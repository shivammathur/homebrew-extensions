# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8995f602584a5267999f51cbc73f8c03eee36074.tar.gz?commit=8995f602584a5267999f51cbc73f8c03eee36074"
  version "8.3.0"
  sha256 "f20f5b318b780fc8436e10988dc407e4dda61220f4902ae5e90e3a1178b6a52d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_monterey: "6989491412b3ba342cca959e1ca299f95b2dd7dbb42b4bb3e37e7d761d10423a"
    sha256 cellar: :any,                 arm64_big_sur:  "6f2f242722f24820439fe13c45bd9f61a27fb78d226cee0c0eff681342926161"
    sha256 cellar: :any,                 monterey:       "368b0340a99f0684a05cb5b3741885f337f73f03de8c2eb5a4d4e02f53bafcf8"
    sha256 cellar: :any,                 big_sur:        "e6fe1867ad4745f555816a70ed04545714c7de19a72a41b28e1b4f5c297040ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7b6633c719daf12fb7f34b50decc4a557cb87dfd98541b013e29c9c38ecc4143"
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
