# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.3.32.tar.xz"
  sha256 "94effa250b80f031e77fbd98b6950c441157a2a8f9e076ee68e02f5b0b7a3fd9"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "b4d2a9dbe557e04c271e1b810dd74671b61179e13f896cdd3b41f84fd63c6f58"
    sha256 cellar: :any,                 big_sur:       "50e41637f6d36b362bf91c42b23bbed424a6c597bca2f77b54bb59016b6718c6"
    sha256 cellar: :any,                 catalina:      "6dc51d554a527e40451271a0ae573626f1e72589bf84a3783a5dcd688cec4c76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66ba76de0486d47927663b9b6e5cfb07124fdd89cfc216567a80dda16f8ab4d8"
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
