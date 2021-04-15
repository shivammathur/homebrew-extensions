# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://php.net/get/php-5.6.40.tar.xz/from/this/mirror"
  sha256 "1369a51eee3995d7fbd1c5342e5cc917760e276d561595b6052b21ace2656d1c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "ba83a07ff9d1b3c7dccdecad406d8191a545066867646fc1e4c4aa4daa61bb9d"
    sha256 big_sur:       "40361f7c8b8561a536185d823283ab0f71ed7d7a586216b624ad8cd2b80d6258"
    sha256 catalina:      "1fe208cfc69e94ddc95a2f472e0ca2e9c4a5393361fd718c82e62ad22fe1eea6"
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
