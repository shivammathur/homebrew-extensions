# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.24.tar.xz"
  sha256 "8e6a63ac9cdabe4c345b32a54b18f348d9e50a1decda217faf2d61278d22f08b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "209529dcb839bffdc36d3d2aee5dc1411cf2713fd49c46029e5fecd12a75f490"
    sha256 cellar: :any,                 arm64_big_sur:  "bab200c6d52c19783d2984e5f6256f189982b7f315fbfe75b9a9a455fd257d72"
    sha256 cellar: :any,                 monterey:       "4f85250e5e8589104be7315657fe8727d82627fe8401e474fbf9638cd7e4d642"
    sha256 cellar: :any,                 big_sur:        "bccb2bf6c2c6cb33bd9919874c024d6299e98d2c1d5e58610835452aea3606f5"
    sha256 cellar: :any,                 catalina:       "d5d24396162546ef4f619dfccd837f2a79022ce35f00277ea9e5ec079663de07"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9f41e274c8471491720ca06726fa75ba4ebf17b721cbfffc97b7d61f127f4745"
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
