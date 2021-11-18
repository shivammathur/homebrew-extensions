# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8965d6b2abbf58b53af3fd4316cdf8f9db67f136.tar.gz?commit=8965d6b2abbf58b53af3fd4316cdf8f9db67f136"
  version "8.1.0"
  sha256 "fefc4b74d043cf31479be55309417c82790bcabdd255c7e4ad5d2ca0c9063bcb"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 35
    sha256 cellar: :any,                 arm64_big_sur: "fd0179a46c52ce0beb0b50c0faefcf1b66bc66624b6bafc7ccbf9eb161b6c6bc"
    sha256 cellar: :any,                 big_sur:       "f3508a0f41bbc5a52d36c8a7cbe78d3a3c927aabebcd49a0525b219d3dd6e4ba"
    sha256 cellar: :any,                 catalina:      "371203d46673c24ce45deb566ebce3e7fb5bfeafc09016ce2ba7e7532d52ab40"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e5f119da830273771b4a53a77ff3f9e5c9d984574d24cd0f5a3eb81330f9f2b"
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
