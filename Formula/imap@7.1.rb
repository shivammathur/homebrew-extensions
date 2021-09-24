# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.1.33.tar.gz?commit=6d934d70f1fa63248671520c6229f8af7ecb4f1c"
  sha256 "0f65222e8f5a8ca5577ca3c364eef70bc4299a294bf30b84213ff1e5e772bf03"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_big_sur: "0935cd65f56ccc866a67c255f8b2960cfada74db35037dff52a1a564a51b546b"
    sha256 cellar: :any, big_sur:       "98089d9689e1f8110a4066c68ad41f8deff1a9103b046c59bf52fcb7ee37b79b"
    sha256 cellar: :any, catalina:      "67dfced9272525f6bd26c3f34596ea5c3d31da8a444ef4d32d420cc86c03c095"
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
