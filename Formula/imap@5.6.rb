# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhp56Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://php.net/get/php-5.6.40.tar.xz/from/this/mirror"
  sha256 "1369a51eee3995d7fbd1c5342e5cc917760e276d561595b6052b21ace2656d1c"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "8b897ed9ba583450ac4d4cfc7144615a94c9f784429170f05f89966c2ff62995" => :arm64_big_sur
    sha256 "2bcc9aec3c7f63538306eff04f5a06d3ea1dda6241b9701090fcd5d765a57b89" => :catalina
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
