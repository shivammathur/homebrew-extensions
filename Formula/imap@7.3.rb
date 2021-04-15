# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.3.27.tar.xz"
  sha256 "65f616e2d5b6faacedf62830fa047951b0136d5da34ae59e6744cbaf5dca148d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "c1f0d83ffb72b3f182604bdd7bfc3fb13aa2c190733c2325762eb0ba66824693"
    sha256 big_sur:       "f2a427989799b09b1d8becbb220e23bc273d44d42f3ad0f838464e4a007d3f82"
    sha256 catalina:      "a66038bd8c3c698aba3e3fe7e8439e9f919572c5135bd99015fadb1015acd9fb"
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
