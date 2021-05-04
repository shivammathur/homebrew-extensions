# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=31c74aaeebf3af3c87e3981703f9f775c65600b9"
  version "8.1.0"
  sha256 "40de25547275b5072bbbbf3b1f379a6872ea636a8173d65cb3be205bf1d29acc"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "c38686cec3015eb235938eded8c171c96db9d35d76047ab1397d07c8febadca6"
    sha256 big_sur:       "b0f510f6189091500f1044afb64a8a672ee936fd17286e5a3e3d1fbe4f43e239"
    sha256 catalina:      "3513ad765a98509764a353a4f48d8b7a32f29cb41e396c088fd1f97ff04c5621"
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
