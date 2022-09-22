# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0b2fe40d23d88106af3b15d5451a7dcafb961132.tar.gz?commit=0b2fe40d23d88106af3b15d5451a7dcafb961132"
  version "8.2.0"
  sha256 "66726bae8da5e527a5fc50560c127732657ca7be30e56ee233a1e29bde3fec17"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "ec9e5ae0ed38d443221d97a58bbb352d2509df5b727c77033e3fa8b563420982"
    sha256 cellar: :any,                 arm64_big_sur:  "bc49f9085d9f7c536e8070ba7b906435321e97982cf35735c43515c66d7629b8"
    sha256 cellar: :any,                 monterey:       "4a3171a6239405c69ae5710d1fab2523e98085472220482afa9082ee3bcd11f7"
    sha256 cellar: :any,                 big_sur:        "f6025aaa28896a580c07c7eb1251289d0954397a6951215c2230a82e2d0861d6"
    sha256 cellar: :any,                 catalina:       "c69ea51fdad7b52c3c19c0cb22b5eb4c330fd53cbf42a293bf6b095e00610dfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dfdef8d94226375446bb80bd92395fa87da5f1863a9e07bd13919bdf0f46d096"
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
