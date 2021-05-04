# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.1.33.tar.gz"
  sha256 "9c1f75be87b7e77fd00b2f29c21f7cb6c258e80ccec7dfcbfe4b72269d7126af"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "36aa84d7a1933e757b7b19a1065ee77018282a966026a20b858ba79040f5d1a4"
    sha256 big_sur:       "3e73e1fa95a613d29d1e7cc80889a8c2d0e8d516d74a219340be39434efa7d7b"
    sha256 catalina:      "d46be1c12f1eb63b38e0320712c95c0b834a7b60bb3621a8ba7a2cc7450e25a3"
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
