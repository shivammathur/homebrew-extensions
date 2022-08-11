# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.9.tar.xz"
  sha256 "53477e73e6254dc942b68913a58d815ffdbf6946baf61a1f8ef854de524c27bf"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5739222b3bf35fd7846c6ba9c896d60541c54db5775321cb957dcd27d86af0f8"
    sha256 cellar: :any,                 arm64_big_sur:  "169e7052c71c2b7c8383c4155d7796e2bf2a13899999b7f3caa4e33f1849ca95"
    sha256 cellar: :any,                 monterey:       "0ca325d64c82ae80ff5a817153e7bfeabe5d24e27ff0ea4c66717be97eaf576d"
    sha256 cellar: :any,                 big_sur:        "ed1f393b407dcaaa83650c9367e507fc19613e3e505337225fa04374d4309cb8"
    sha256 cellar: :any,                 catalina:       "b4f27ac8402090dc2866712ace5e80f9a308b7c9e676c832f2e495ea07d3e08e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8563639026900fd7f8bc6fccc2e7d753b88fcf4f890c6a27ac6c1fb9e23385dc"
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
