# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.3.tar.xz"
  sha256 "b0a996276fe21fe9ca8f993314c8bc02750f464c7b0343f056fb0894a8dfa9d1"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "577a2b29a8b1fa9d14a5476e140c471b30500377a0980a75dcc43921adb3bfc8"
    sha256 cellar: :any,                 arm64_ventura:  "c415943fa6724806a2eee2931a86600f70fc80b36c7e2c3341221507711fbb42"
    sha256 cellar: :any,                 arm64_monterey: "d95692e711ef0afea97267cb7842a4669aa74cf51d0b9e674b2f7801261625c8"
    sha256 cellar: :any,                 ventura:        "8dbbe34c825143dd8a7c031bddbe52de34c0fb8f9df36183a47b1eca19ed3032"
    sha256 cellar: :any,                 monterey:       "0f9658ff85a0f64555f07c7885669658ed06684192d70a26a905b7d115bbeeb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "615d01e3e202957bb9a56dfe02d63ea8eef2a69cf2d45c1c72043eda7e1a501e"
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
