# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f35a22adba8a7ddf709c6cc98ecb57ba4dd8fe8c.tar.gz?commit=f35a22adba8a7ddf709c6cc98ecb57ba4dd8fe8c"
  version "8.3.0"
  sha256 "606158dcf15936552e4660795aa0f4258a3eb0814f2b42b6ec667db0dbe8686f"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any,                 arm64_sonoma:   "ad41f11de3e36092b67f5b52f2189d51e0514900254f7fda96da52ce7a1f3071"
    sha256 cellar: :any,                 arm64_ventura:  "239316ecbfe95ae98f8f55c9f33afa7f69c6691a0de0e17386854d106fad13b4"
    sha256 cellar: :any,                 arm64_monterey: "9bbb292b8790f3b1c3dc89d283110edb76991eb44019592ea7a3c0e7d87b59ac"
    sha256 cellar: :any,                 ventura:        "18fc416daa4fba5371e8d768a5bfba3ccd459804ec422249c29a1aa5ca4668b5"
    sha256 cellar: :any,                 monterey:       "86a0fccfdcc9b124974d2f01033cd1a9c4365d32266393f76ffcea095153eee3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "198d9409162f4564cecc4c93db7b18c4792bc4bc45060b0e9554127207a5fc58"
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
