# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.19.tar.xz"
  sha256 "6c17172c4a411ccb694d9752de899bb63c72a0a3ebe5089116bc13658a1467b2"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "487d0292c78c2f93380c55ee295c1d578daca23c97789e8bfd02fe1f70ba55f5"
    sha256 big_sur:       "cc36c9c198f8ec87c59d55432b47f0fd5ede486c921fd2943cce61204eea4aa7"
    sha256 catalina:      "07562d6a3e87fbed8c1e66e32480f5896991037a69cb31b8b3813b45ebe29a0a"
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
