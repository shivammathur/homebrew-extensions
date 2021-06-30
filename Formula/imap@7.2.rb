# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.2.34.tar.gz?commit=7598733c51af30611aa64e456c9a777069d2efb9"
  sha256 "01e0d039f916050aefa0d3bba2fb406e3ba1fa5ed46a5b1245b633c40a0c50f9"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "3626f1cb97192f303e5a8f4a4396c68854d72e78537f66112786c194e1be03c5"
    sha256 big_sur:       "3a0a507c367557068328520faaf00a0c74b00c199f0bc8e5a4d0da7052a3b022"
    sha256 catalina:      "54e9c60ac72f280d3599ae7eea985a0f6198452cbc0ee1843d148ff50801dbef"
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
