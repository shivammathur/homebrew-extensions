# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.24.tar.xz"
  sha256 "ff7658ee2f6d8af05b48c21146af5f502e121def4e76e862df5ec9fa06e98734"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "b2507a03bdf942f7022031c2278e6152d01e0fa1e041086fb83e983c565e5289"
    sha256 cellar: :any, big_sur:       "5c1ca531f7cd25aaf313b3d5d77381f20b9495167aea923eda4192f23ebeecbb"
    sha256 cellar: :any, catalina:      "f2be321f8d91098c1287a1d40493c25afa3475f59aaf7640637bd7a929ef43c9"
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
