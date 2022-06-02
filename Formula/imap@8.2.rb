# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/bbc738e96b7bc97a77e4a1a04aada748963f90d8.tar.gz?commit=bbc738e96b7bc97a77e4a1a04aada748963f90d8"
  version "8.2.0"
  sha256 "52e4a4decf7a901724064923ed516c69c090c4e5549c322c5777d95bd87abb8a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 52
    sha256 cellar: :any,                 arm64_monterey: "41e52c0473fbd4b74934abcb527c1dec508dfba8202f11e6f3430dbe99e381e3"
    sha256 cellar: :any,                 arm64_big_sur:  "f5f36596973f3a6c0a6b48d4cf6d341bea13a09cb04c92a37f9120673e00401b"
    sha256 cellar: :any,                 monterey:       "2a65dc82932be777654755686f4cadf972c0a783375a9f07c6f8a798ee485d80"
    sha256 cellar: :any,                 big_sur:        "ee19879cca4e6275bee20e4b6f9e66776b1609246643eec44163f7b0e8ebc0d4"
    sha256 cellar: :any,                 catalina:       "fd95dba35d18ad2e42afe7fa31f72a3e8f15fee3ed761d2926a72c6b37c78b3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ae2cf4dabaf85492e83957e6cedd27d2ecf14eba0928a86bb3569d35a0c1d725"
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
