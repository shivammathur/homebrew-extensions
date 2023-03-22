# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.17.tar.xz"
  sha256 "b5c48f95b8e1d8624dd05fc2eab7be13277f9a203ccba97bdca5a1a0fb4a1460"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "6616201e4ca5310163c195b1b0664f1258ddbec64721855d65c839f37f8b73df"
    sha256 cellar: :any,                 arm64_big_sur:  "0c411503ca4e27c8a8d1c4baf87b3ff26bc1aa918093992208bd46e884687368"
    sha256 cellar: :any,                 monterey:       "3a486e6d7e9085869425463012aca0faab475665466cfce3f94ffe575ee68c9e"
    sha256 cellar: :any,                 big_sur:        "c2a1c5a577d74fefba58378846ae44ceea4e8cb4c60d96277378fec640c3e788"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "449a94022888e7ab49f4427efaf779e09caaa22ae4274b45b634db6e6e3fc4ad"
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
