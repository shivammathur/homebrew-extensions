# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.1.33.tar.gz?commit=df9264ca80d5a0ed94b8eda9e7b06e6f7f388790"
  sha256 "f4b7259b023f6f9120fa6c5be09cc7541d00119feae1511acc16fe4ba6b0ec08"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "741aab5ecd8419c29c5420228a2906c2faf7ef2628f56b06d983cb5442ae6a3e"
    sha256 big_sur:       "0e904f6317950506ae717b2679deea4ec283967e754f8c524d933ec5aab8747e"
    sha256 catalina:      "aa983ed5be009cf784652ace34dcff81131ffb58859681a2f3d76158c453c45d"
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
