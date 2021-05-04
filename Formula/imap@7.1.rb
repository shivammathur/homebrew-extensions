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
    sha256 arm64_big_sur: "894d2119c94ca916e93bfefb27bf2adfdb41e57681e5b5b0c6c9c7d9187b96cd"
    sha256 big_sur:       "158cb62e7b76b7f4758816e381ab319784a7775e2cc4aa3341e286878fa3276c"
    sha256 catalina:      "d506e0fd56f3eb4883022c3ddfe131ec34cfb8e6d406ae73a8ae92ab73a93cc1"
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
