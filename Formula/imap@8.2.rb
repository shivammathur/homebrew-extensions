# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/97cdf62a6a1d8491f8d1ef1580f344400eb51f1d.tar.gz?commit=97cdf62a6a1d8491f8d1ef1580f344400eb51f1d"
  version "8.2.0"
  sha256 "ba9057e0c070c3eb933784d1a0e6485b0a99e945ebd55e1dc455fa963b665acf"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any,                 arm64_big_sur: "9c6964618afc6b054f197e7bc8b9813150133c630b2a22990f2ba0296e592e3f"
    sha256 cellar: :any,                 big_sur:       "7b02ad933b82a92e58d884fd579ec4cb5bad18867f2c74b947c39929038132fe"
    sha256 cellar: :any,                 catalina:      "a2c64649502ffea77391923695fa8e0b12cc50d09ef41251a820f8e3c84b7e7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a3bf2bf0411b5adfeed530b197312472267c6042032557750bf8eb4f2b6ecbb5"
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
