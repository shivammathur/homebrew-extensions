# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.20.tar.xz"
  sha256 "1fa46ca6790d780bf2cb48961df65f0ca3640c4533f0bca743cd61b71cb66335"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "107caa479947e96852809474cea7a97601ae2b265a1db0bc9e14a234ee31ca44"
    sha256 big_sur:       "702e30e620a4fd5876b07d8d3137304886386bfdd18d17b7d4fb27652aa636f2"
    sha256 catalina:      "d881b33688f8b5b24188c7b6f5353f1d86631d3d4a297207241a6fcacad249f0"
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
