# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.17.tar.xz"
  sha256 "4e7d94bb3d144412cb8b2adeb599fb1c6c1d7b357b0d0d0478dc5ef53532ebc5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "74b6464e70bdffa16e86b48c94710418a0f4874fbfa0ed4d35db4024d67c9796"
    sha256 cellar: :any,                 big_sur:       "a9bc0f009504c05f5cdb076d03dbd443e6f5996862ccd4b8b73948748c4c816c"
    sha256 cellar: :any,                 catalina:      "bbb8648fc398aa76a1b2404ee9cf2cd853f81eadd9ad6212c7296d024fc07cca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a493500f038f50e932c5f19f609a77d88a2e9b60a35d78ff0ec8340e9257e050"
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
