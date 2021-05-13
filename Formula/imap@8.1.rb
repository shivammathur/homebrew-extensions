# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=96adc806e01056659d94ae700a51e24609cfe91f"
  version "8.1.0"
  sha256 "6cacee32abe0e0b649a47d77ce61924a7404137457093aa4822475fcc4809b0e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "b357916d8a0b572db55198253e2ab03e0d273974bd33a26c66edf98caa6c2c58"
    sha256 big_sur:       "dbd2e656599f1bac41442c7d9642823c17c7a489b7a95f10b51ae24ab1aed348"
    sha256 catalina:      "b971d09fd5795c0cd8e1cc38df562e903f4c5864c5eb1d8c349f56c1c924e738"
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
