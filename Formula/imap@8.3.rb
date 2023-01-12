# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/428043105087da4d69d9ab8668d7448d5030c989.tar.gz?commit=428043105087da4d69d9ab8668d7448d5030c989"
  version "8.3.0"
  sha256 "f54e265f365f912cf9c2a06f07985a429b3edf9ab9b58b6f358ecca0bc573a13"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_monterey: "4b934749cce1e5f0c7e1a8a0fcf13e3c4a2115423cb78c8af1f71f2c22b88bfa"
    sha256 cellar: :any,                 arm64_big_sur:  "6da614a03d19c63201f2ecda58be1842564070a2238ad8937a1f43f535d9bca3"
    sha256 cellar: :any,                 monterey:       "d6eb15fb7abb7d4b4e5ffc12f87d7e734885223e0cb17f7d0692d5b14bfb8be7"
    sha256 cellar: :any,                 big_sur:        "cc02076e5218c1172052df7c16531846167d887a7e7c17e8ae013ea9d7844535"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8b56d2d6cc7f4ab788b3fb77e12e4dfff9713f52d3cc320b43db1a16cdb8e9d"
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
