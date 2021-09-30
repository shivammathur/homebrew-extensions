# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6768aae40ae6f007e06ecce5c506b4acea5897c9.tar.gz?commit=6768aae40ae6f007e06ecce5c506b4acea5897c9"
  version "8.1.0"
  sha256 "f3581463a93babe994087a90c267fe0310da4c644c68c7b87fee625f2ad19afc"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any, arm64_big_sur: "6e57733dedeee2873ea632d56e2a789500e94e0472c91085cba384eea4cc4785"
    sha256 cellar: :any, big_sur:       "8ceb0a9ca434a5ffb77602b5f1e3527fbef32b0e69092294d382aa393f9e7458"
    sha256 cellar: :any, catalina:      "b4b8403bc221b6924b1ddc8d6e51698bbed80f8c1935ef0351a54424426f20ec"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
