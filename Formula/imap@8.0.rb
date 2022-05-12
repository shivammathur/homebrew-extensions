# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.19.tar.xz"
  sha256 "ba62219c4b0486cbb2a04f0796749a46b0ee1f5a142ed454212b4e2460cb0fab"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "3b3291d9804310b32a7b6af5e20ae909d899e13f851d240feda69169912a2e25"
    sha256 cellar: :any,                 arm64_big_sur:  "9048ae3503d54b59b1a3d4156b66d2fdede27b3ff38f70b41190bc12f18b6b3b"
    sha256 cellar: :any,                 monterey:       "b9757da73bd4279bf6bdf0ee1b090d485060d6aa8b138b7afdef66bd733001b7"
    sha256 cellar: :any,                 big_sur:        "2f35e5610f74f89093edb77d59c286819a8c233ebd079cdd632d624ff403d44b"
    sha256 cellar: :any,                 catalina:       "36a3f47a31b8cf45ed7f58fd93e79a0eb007e81dadc741084ce5ca038ba6f294"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6735aff4a08a451ba7ce7e50531eb006a47382a5dfa46d5af82ba25ba94cdeac"
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
