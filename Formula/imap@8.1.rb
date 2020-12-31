# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1609390513"
  version "8.1.0"
  sha256 "a8f3ecb208ded4eac543a4b999f8a5a012103d8076f6c217c3d5569c59f5dea1"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 18
    sha256 "6e2cec33d4d023bf62fed2c31bbc34d57906c8c60dcfd5b575d3365bb6b940f1" => :catalina
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
