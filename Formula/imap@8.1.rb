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
    rebuild 4
    sha256 arm64_big_sur: "63002f519946463ba2603809a40e5c54bcd80fd5a970a3f692f54f98c583a227"
    sha256 big_sur:       "2629ab95f908c54f3c7104244c5bdb7a8d12ae52b1da1c10b08624ccae5cf569"
    sha256 catalina:      "2428103fb15d1fd4a27a1ebeea05dc6d02f9bf9a6e5ebe92c40a9310a651359f"
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
