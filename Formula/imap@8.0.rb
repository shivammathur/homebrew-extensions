# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.14.tar.xz"
  sha256 "fbde8247ac200e4de73449d9fefc8b495d323b5be9c10cdb645fb431c91156e3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "e7c1a3308d106a07d108fd84d9258444064f84d62d35811b31a812c2753294e6"
    sha256 cellar: :any,                 big_sur:       "44aa726c300f33b8f7df4139af103481117ad180f00f2299c0cb9aa3e9ad7c59"
    sha256 cellar: :any,                 catalina:      "2c77f15fb8662e5d95a73cc0f699903e0793b26d72d979c8fa0722f068164b2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94a80d3375417e9711b9eecd4a71767d469ff925283dcbb65102bcf427e89f4a"
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
