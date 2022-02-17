# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.28.tar.xz"
  sha256 "9cc3b6f6217b60582f78566b3814532c4b71d517876c25013ae51811e65d8fce"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "353919dfc58cbd467df95531b6f373924e13aa4726ffd442b38e063a8924047a"
    sha256 cellar: :any,                 big_sur:       "015870ffee5f98107524b71aea92155c9f2348a4f727e105ede5aafb1575d8d0"
    sha256 cellar: :any,                 catalina:      "72b88e097a2d66b829e5eb71893d7e6a5d6224e8c318150d5eb68c7e15a1a5e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "813082a532d5b1f34a7cb5a60bf6003f673ac552512bd034042cbc9fb51fbce7"
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
