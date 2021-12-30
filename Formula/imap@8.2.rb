# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a0ba10436c16452072c045bd74d0a9c27b92606b.tar.gz?commit=a0ba10436c16452072c045bd74d0a9c27b92606b"
  version "8.2.0"
  sha256 "b8cf6b53ef93b642067f03dec5454d634af7dafade258c311c930330bbe4a345"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 27
    sha256 cellar: :any,                 arm64_big_sur: "b6000be8cb98f68a4972d78f0a39152029581ce1b50c9b7a9d7f5561882b2f68"
    sha256 cellar: :any,                 big_sur:       "1bdf6c8413f916e0862e0bbc7be670deb5f804cc9a3cfcf0ae305c3bea6ce25f"
    sha256 cellar: :any,                 catalina:      "d7201c6b946f19a2aa5e521fe9499d4f9ce7f1694c438d0efb4684f0eb2190b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c14c5c6e87815c79d695b7460c9fab4a81ae206ebfb5ab1d6ab4aa77f598576"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

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
