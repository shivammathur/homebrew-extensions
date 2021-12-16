# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/83ab580850a3a77acafaecb39560d9552d998f98.tar.gz"
  version "7.3.33"
  sha256 "45eface7cc06451deddc0e7b3840a156ce81bff1efd9cc4b6b793948813c8c3a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "720e95679197bab1624ea6be282932f223c5692981fe7088d2a41c63f76102d6"
    sha256 cellar: :any,                 big_sur:       "1f3d7f04f22022163d69e491159cbd016c3997541804d09c55ef96aa31fb8f56"
    sha256 cellar: :any,                 catalina:      "302a18f474f8975ebb99667b04e355f59205ff39ec87a8d27a02c1cdaf375a4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8aaa733cb0b4ca487bf3258c7fa58f654efdd45ecf17474e18a861e20372f0ce"
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
