# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhp73Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.3.26.tar.xz"
  sha256 "d93052f4cb2882090b6a37fd1e0c764be1605a2461152b7f6b8f04fa48875208"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "93f99a2f1d8ee89866df9c8f7d246642b3f972052d4108329c17f72729cdfbe7" => :big_sur
    sha256 "813e0e8d1d362ede8417a6cc340a5bbe0890fab77d4014f82e83866f6d67f8db" => :arm64_big_sur
    sha256 "66c96e14520032b0a8e2583a872739cd2f7250ba7ad31764d2ba62bc791ef3ad" => :catalina
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
    write_config_file
  end
end
