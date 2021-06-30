# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.21.tar.xz"
  sha256 "cf43384a7806241bc2ff22022619baa4abb9710f12ec1656d0173de992e32a90"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "a9f642605574f040e54edaba50a625df26f50897a73f8a552bdadee19c91bcd2"
    sha256 big_sur:       "caad0fd5c567193a8fac134008e98348877cc422d51cae8df8a75525aed3a2ee"
    sha256 catalina:      "41c21c70f508d0b7ce6d02c57d157f5ed8f01987a40c32178b03d10200b108bc"
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
