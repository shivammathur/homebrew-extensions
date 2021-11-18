# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/17777ed335e9cf1a9268bde1267790c9fe42048b.tar.gz"
  version "7.1.33"
  sha256 "4bd588092d65ecb05321bfe26f616e90c912f33138b9d36a7e79c92fa4b41434"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_big_sur: "4a9414785258d792b5d3bf8aad6be2f6e73c8ff2a4d51e64c68ea81941b057e3"
    sha256 cellar: :any,                 big_sur:       "bb7ac3df8d8c690678e19f436a52bcb4cb6d0cf6694db877c79f3111383668c8"
    sha256 cellar: :any,                 catalina:      "c52f6e26488397b858679aefa700d85f2ef1a86ba6ead119f9b5a7ce66edd610"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "38674451805b2315cfdbb05cea1a7c2cd3ac6d12ef3b558d54d054875a0c6f29"
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
