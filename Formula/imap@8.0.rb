# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.3.tar.xz"
  sha256 "c9816aa9745a9695672951eaff3a35ca5eddcb9cacf87a4f04b9fb1169010251"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "3ebe6765a5737b322977b322efb2121621d10e0a768778521be080abc675602f"
    sha256 big_sur:       "71269ad7525691c90da6bb7e8a2804817d136c15a08174d1a3e523e5bc943bfc"
    sha256 catalina:      "72e9f24e4abc126061658150a271474d157ea86d44284fd648bc91e95bfc2867"
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
