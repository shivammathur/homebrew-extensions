# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7cc3c7a8395d963d3129e2d0f473d847f21df13d.tar.gz?commit=7cc3c7a8395d963d3129e2d0f473d847f21df13d"
  version "8.2.0"
  sha256 "87685b0bf67390b4e622b4885baa187be1c4409ce3757063682511baa7d336ed"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any, arm64_big_sur: "090cb4624b17fedf88a2124e33aa7a68d6d7852185157e2f36c5f9d4e73a0163"
    sha256 cellar: :any, big_sur:       "ccf7caedd44afa23a1421ba540368165bff773796682e1416f3235832539ea77"
    sha256 cellar: :any, catalina:      "bcd8ac9f7237fff270687b20a7a8d46ffc9bc4d06caba4dc85594b407d1241c5"
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
