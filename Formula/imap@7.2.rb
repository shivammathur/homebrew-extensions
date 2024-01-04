# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d6c57bbc42a5b41fb67f63efc5944d217049e5f9.tar.gz"
  version "7.2.34"
  sha256 "97cdc321dfda41800a0082e48b66780cef2515c366066b1a1bc7493e09d2b43f"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "4e9ae6a30ce0cf8242c187d1c819514a891d0cb2e0ba3c48bbf359c44c2758df"
    sha256 cellar: :any,                 arm64_ventura:  "0fafb6afb0cf53dd2147299debed532a04f7834ff72d97ca4f956ab5581cc3a6"
    sha256 cellar: :any,                 arm64_monterey: "62be014a0342f3f25d60a4ead4adfb1b0fde4bf58cbcb343fdb697ea4653c1bd"
    sha256 cellar: :any,                 ventura:        "d0712a77998ba7c4d767d406b9a2065107967507c52e0950c5b3ef6815c92107"
    sha256 cellar: :any,                 monterey:       "54681852d0dfd59fe0081766aad4f513c4012d7bd24e19fce680585f95028e6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "98413e568cebbee74cf76d546b8254a41ff0e58113a71c0ba3f9fdb8c6287208"
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
