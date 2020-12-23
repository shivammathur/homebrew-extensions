# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1608743785"
  version "8.1.0"
  sha256 "7ebbf110443192d23dac16a671d7bf498735eee9f3c788614b8ee3dc034e54c2"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 8
    sha256 "c30e2c44e3e18a749665b44271ce5a9dc1a25325bd5766ddf7ab25801d29776d" => :catalina
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
    prefix.install "modules/imap.so"
    (include/"php/ext"/extension).install Dir["php_*.h"]
    write_config_file
  end
end
