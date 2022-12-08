# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.0.tar.xz"
  sha256 "6ea4c2dfb532950fd712aa2a08c1412a6a81cd1334dd0b0bf88a8e44c2b3a943"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 81
    sha256 cellar: :any,                 arm64_monterey: "bd10d34b6eb6c4e7929ed1c47b06e7ad020d9d6b115b2a1a1fbb4b027fb76d55"
    sha256 cellar: :any,                 arm64_big_sur:  "d915acc9e3dffe33322c7c7a33273bb2874e6fe4ed9edcbb398fb3a5f8e8a689"
    sha256 cellar: :any,                 monterey:       "09fd4f624a7e67327d0cabed147856b97cde293193477c2de75a422f8d595811"
    sha256 cellar: :any,                 big_sur:        "6c2c98ef6f2e6babd959cebb794c8ae72b043babc92a69ddf77087f9182d574e"
    sha256 cellar: :any,                 catalina:       "dcc2f3fbeb1a24b1fd4f470d6341017b7f6dfbd01a0a6548fdd7f129e1f402c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "51a4c8a28d8c60aad6c6246b902da90515bdf8a8f058b77d2cf67820130ab71c"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

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
