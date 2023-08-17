# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7e4ca2e8d9fe9131eb24e29a8a508059b95018f9.tar.gz?commit=7e4ca2e8d9fe9131eb24e29a8a508059b95018f9"
  version "8.3.0"
  sha256 "4cf73ec4385ab0914416beb130e693cff6db92413fe288898f920c0f57346b24"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "cf484f148f57b1f95f3eb522846d4f6d01da5ac842a2b154cff51dfcdb017051"
    sha256 cellar: :any,                 arm64_big_sur:  "7de5c10eae2cd8e027558cc50a560f2278857a79581d7dc69c04ea1430a5d6c4"
    sha256 cellar: :any,                 ventura:        "4618e4e332579cd901c80c945abe7ee06ecacfd612f0cfac6042735b33c8e3f3"
    sha256 cellar: :any,                 monterey:       "401816d04993fd39197f53cfd5dc8f2df016e76714934e01535571117c9fa95a"
    sha256 cellar: :any,                 big_sur:        "16db59ddafecfe832fc6d5c8152f1b64235d8fc569f8d571191891bea24a433e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "22efc83fc46ee0b7b74ce743d1bb3a0043b2e87ed32e13df9be42456597e5b69"
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
