# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.3.29.tar.xz"
  sha256 "7db2834511f3d86272dca3daee3f395a5a4afce359b8342aa6edad80e12eb4d0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "22c8b2cc0dfc830e984153efcfea3fe4137db5c08e5179333cdaff787fe40f60"
    sha256 big_sur:       "43822d3cf96e2899807bad6ed4acea87252df79d1d08091ccbaa12ea29f51897"
    sha256 catalina:      "4722935acd8ce4ecb8a1be1ca381602059aadc3367a3b5e81e1bbf6c0048a189"
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
