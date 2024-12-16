# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0b2d7b889ff02945ff13e630654f861fd6d04851.tar.gz"
  version "7.1.33"
  sha256 "18aa3a76a05c2c9b3c8b1452d64b6b31bcb58bc163ce9927f1751f2a8cf81e23"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "419f775c88ceaec6480194104394426439000a94535fdccb1d894973c6b0defc"
    sha256 cellar: :any,                 arm64_sonoma:  "cce9f6259a5b38512b3b9866f7a076a0b906fee064e9ddcedbf30b1a00f896b2"
    sha256 cellar: :any,                 arm64_ventura: "7d4aa9369238b74ac85be576f3d14b7cb386bf61aea490cabaf2e3c015e05440"
    sha256 cellar: :any,                 ventura:       "ef1e9f79dd02ebe11d8649a64804bf93db4052bbdf1a91a6ed0b9474e4e256d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d3210941d7d571638d837aa9b7ec50107b864e8ea7a34cd5bd825a69b93384c9"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
