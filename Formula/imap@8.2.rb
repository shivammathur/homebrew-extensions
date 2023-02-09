# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.2.tar.xz"
  sha256 "bdc4aa38e652bac86039601840bae01c0c3653972eaa6f9f93d5f71953a7ee33"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "96ae5c2205869b6717d89c93527213c1769b22a8f2eb0d4863c2c08a753df6ef"
    sha256 cellar: :any,                 arm64_big_sur:  "8282fd1f6a937ff6cf5c002e93c9a1ae9203b053d47ca24c39703a66a750d0ec"
    sha256 cellar: :any,                 monterey:       "eb4038a6527f0ed75e502bdff01732fd6e0e189c94547142ddef0037301630fd"
    sha256 cellar: :any,                 big_sur:        "8bfe3f6e2ff7fdad9025209aec696996427f4d5b9245da30cd9ce1324131ad1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4f2bbbc6d166495f9493539942025ce6c06ad03aaf6a39d522f01f59edcdaa39"
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
