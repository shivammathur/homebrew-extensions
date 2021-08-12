# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6729276684ea20b42a7e44cf0a27d303308d3578.tar.gz?commit=6729276684ea20b42a7e44cf0a27d303308d3578"
  version "8.1.0"
  sha256 "f7b431e1d44171bed7bd5a7c120d883242d2ed25081dcdd467ec8e4c9161e0e5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any, arm64_big_sur: "0c518af1e01dde73592a541e80f8a3371648cabff146274a1f99ec3d2cfd48ef"
    sha256 cellar: :any, big_sur:       "e75ba168dfe07b7229250e26b5784856522e2a78a6779a7410fbd6ec6d21c86b"
    sha256 cellar: :any, catalina:      "62156e5598ec72e67c63058f7895c6443d5b73700d7d33548f1f708b9df9d0a7"
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
