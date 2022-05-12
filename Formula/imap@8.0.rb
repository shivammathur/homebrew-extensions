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
    sha256 cellar: :any,                 arm64_monterey: "359eba7ea0d0fe29e26f07bda54fff9b524393fa9f794100f660ea13377aa52f"
    sha256 cellar: :any,                 arm64_big_sur:  "17feda5c5eb8689cbada31f575d1b859db5de0f973af2d42c6b9dfdd10a3c1c5"
    sha256 cellar: :any,                 monterey:       "ee73e91ca0783f3ba1cd2fabbb36fa86eaa4ce3e3c96bd326b352995d9d54cd4"
    sha256 cellar: :any,                 big_sur:        "57a0f4efaba8d25846871339ffdecf25adcc07572932287002dff5ade67c0841"
    sha256 cellar: :any,                 catalina:       "d316f93b20dbf396a95dd2a457b93962091f588d64aa96c62f4b12af4a083bf0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f916fa3cc58ca2a56016da276e88718c072cac09f8d10ced4bb3b7dccc50a5c1"
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
