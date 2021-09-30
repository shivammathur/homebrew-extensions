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
    rebuild 26
    sha256 cellar: :any, arm64_big_sur: "1195c2caccaad76eb73470d02531513b245ad99a8876e0a3b61b5fd231f52b5b"
    sha256 cellar: :any, big_sur:       "581cd41c5fc12d8440c5715310cb8749b99508f074623093df3fe58f9fbe6a50"
    sha256 cellar: :any, catalina:      "35e86e9900040592c9d09a3c71d335c8da2d288831b5b3eedceefc369486cb45"
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
