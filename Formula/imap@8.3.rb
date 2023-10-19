# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a831cbcde44e1bd4fba9eca93945091f0610a891.tar.gz?commit=a831cbcde44e1bd4fba9eca93945091f0610a891"
  version "8.3.0"
  sha256 "fd7d20757616d467de842e7cf47726268e3c3a31073b09d861b5b67536a0ecb2"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_sonoma:   "7b4a663eb0a453b103ddebe69308fe2d34b1e7d7ace0ffb19a24b3b0f4b9bfe7"
    sha256 cellar: :any,                 arm64_ventura:  "7fc302bb52727a28f6b4864e9e9476de7bd4fcb282bd64cddd33f913d5a91b8a"
    sha256 cellar: :any,                 arm64_monterey: "ada0f786a26431be1ded6157e60b00ca7eb25c080c7e0f0992497b731494c415"
    sha256 cellar: :any,                 ventura:        "4b096304b90db1989332b4fdca539578a61232b0cb85f98356e6031b2824fa14"
    sha256 cellar: :any,                 monterey:       "bde12df1a5da7a999f72fa3462538179d1071160ab6ac8f9cb7241b96860d972"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e5ad785955358e290e19a204f95795abc6786d22d0f2c748accc3c3b5a03bed7"
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
