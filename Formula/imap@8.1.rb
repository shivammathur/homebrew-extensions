# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=5de50e28173a100f5bb32959fda398d1f98be5c9"
  version "8.1.0"
  sha256 "28577c0875e04181f5eb744479e40af859647f25e5b5a9c6ba7afa32ce3dae04"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 arm64_big_sur: "671802fcd943cffd59bd37dff779f2c504481723dd22b447150c26e3bf7a4a32"
    sha256 big_sur:       "14f7da824c7ff18ac8d01c90e5958d9ab03c271900e84bc51af094adaa7bb576"
    sha256 catalina:      "a5f1bacee75d16b51b98b3c77c0c97093f620d6379730f24b8de7db5cc5699ec"
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
