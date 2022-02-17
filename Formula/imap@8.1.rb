# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.3.tar.xz"
  sha256 "5d65a11071b47669c17452fb336c290b67c101efb745c1dbe7525b5caf546ec6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "1f54c06527a498fcc41106e8ef1f4f1e2fdc9b92ef9cfd17ce7ab77cfc389472"
    sha256 cellar: :any,                 big_sur:       "4149a1b275b8a7c57e2c9c341a1b166b858f83a872dbbd62225b1fd310c133b9"
    sha256 cellar: :any,                 catalina:      "c3931ddfcd4a1a774ed9f08cf842c7d7ffe6ef4061b9aa79c1c6bbd91e45474e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "74cd07cc6195fd2fecb5a61cab4120815a63daf227da91e75026555a3868ef91"
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
