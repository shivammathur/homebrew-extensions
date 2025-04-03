# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/45fa214ea3a98e645b5a26c53a61b5fee9c39d13.tar.gz"
  version "7.4.33"
  sha256 "4019629d3fe91b18586676eb8feefabc15ed4530d15fd227f405ab62a7e3b526"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "00d3bdc4844b5d7cbc7c511ca2856e3320cf120f638f328a70436fbf9aeda1b2"
    sha256 cellar: :any,                 arm64_sonoma:  "c545d6c96352086b2073f453620d076b95b64424f934e51002602a475679845f"
    sha256 cellar: :any,                 arm64_ventura: "7e24ed4cfe50aa5463d7c78776e0abb56aa092dd32f22478c2c326fe7cd9c243"
    sha256 cellar: :any,                 ventura:       "b214fa2314f8aa76843462c11ffa57d94e3dfe0aba2fec7df254a5f2fbc633f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3a00c3171bfb40d7c0b7a4935928936faebb25f76010e4fab7b85313257a0ca5"
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
