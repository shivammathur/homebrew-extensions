# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.2.34.tar.gz"
  sha256 "72c9ae7a6b0b55b2837679d8b649e9bb141d5c16eff80d0dd06eae09a999e9bf"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "5fd6fe66cd0affbe314183d187c805a292692c037b75a62fab548670ea4242b9"
    sha256 big_sur:       "a25a4c3e8ebc350dfc545f53b96f9eb40ccef8225af579584962f6d401de810c"
    sha256 catalina:      "3456e38a329d4c639795bebae28877dff94e276f6c2d1fc4f7def8b5d398409c"
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
