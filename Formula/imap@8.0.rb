# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.21.tar.xz"
  sha256 "e87a598f157e0cf0606e64382bb91c8b30c47d4a0fc96b2c17ad547a27869b3b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "0c9e49d313af38405c01805180cf4c93d749caa60e2d774152ba69d5f1524fc2"
    sha256 cellar: :any,                 arm64_big_sur:  "f4540eddacaa88a3fcd935a2c46335b9b57034b4d5252ed96097d8eea31c7d34"
    sha256 cellar: :any,                 monterey:       "f92c4fbf7c9f4a4df6a77d2f824f8f14da366545b160317b5f74b0783f27f349"
    sha256 cellar: :any,                 big_sur:        "860297e847e4f10d4b56535e1bd4b9602648989f1e246506151af3c8ef28a90c"
    sha256 cellar: :any,                 catalina:       "7cbb37eb0a0b31084927d30ee73c2f712bb21fc7eab779ceac3c6d75947b827d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "36b3be253242f047639e87906f43593b69d36c44bb1afdaf44289be545b91b25"
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
