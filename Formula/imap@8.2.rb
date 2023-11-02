# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.12.tar.xz"
  sha256 "e1526e400bce9f9f9f774603cfac6b72b5e8f89fa66971ebc3cc4e5964083132"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "6e723935b717dcc92dfbab609532940c84217351fec9282b5dfba453e9d60520"
    sha256 cellar: :any,                 arm64_ventura:  "2f63655f79e01d281d1963221ab510b1d723b85d60379f70d31563a825d182d5"
    sha256 cellar: :any,                 arm64_monterey: "449693a661970d7c5fba0f4b5a55b27ebb81a6ac0620727960128224d6307ec3"
    sha256 cellar: :any,                 ventura:        "93a0e5a1191064c38397d0426f43afc002556b9a41f7a505742346835b44d343"
    sha256 cellar: :any,                 monterey:       "7ead8c6ff38d2a2b69896f02617ea5fe5b15e8d0b350dc24ac500b8d80ce5c32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c40fcc3db84862c24a66c78884b09d36becdcaf8f1cca263103d27b248434316"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
