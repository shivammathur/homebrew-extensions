# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.3.31.tar.xz"
  sha256 "d1aa8f44595d01ac061ff340354d95e146d6152f70e799b44d6b8654fb45cbcc"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "2c50602b9f6156552c8a1d058a3b66e7d43dadae42973a27406aec3c679b39da"
    sha256 cellar: :any, big_sur:       "39952d59ea55620596dbbb4e226607932b9238295a338b582b3bc36696a4e42a"
    sha256 cellar: :any, catalina:      "b2fcf8168c20aadccbb1aefa0e4eb5422f5721155f1918e5519238a4df14324f"
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
