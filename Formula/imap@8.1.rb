# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=ff983131e7c6248a8566468b8457cc4748e06bf2"
  version "8.1.0"
  sha256 "6baafd2ffd24119d0fbcbd7b27b3b755aab09138911a6c3fd44b3c4969f1d04c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 arm64_big_sur: "c3a42d20a996cd055fd6de90bb6885eac30238e67b161854e7aee59d085338a0"
    sha256 big_sur:       "2ff5cf9fc72f4fa44a54834355b3a59a0eed5c9d4b712f7e4122f8042afd8fa5"
    sha256 catalina:      "c59f1c18dcdefec33a95c8de146c01d5776b3c9779acda028a26b9fe3f8f0b5f"
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
