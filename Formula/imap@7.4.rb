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
    sha256 cellar: :any, arm64_big_sur: "0342a6153357b0be37ff5c2daf0d2bff54bbd7632bab9a3705bb6f21b36b7364"
    sha256 cellar: :any, big_sur:       "6ed9b9e9574abb241aec42a04a6a38a165cd4496da561e7d7c37ea44d35e9733"
    sha256 cellar: :any, catalina:      "af856063e74bc634b8b8be1b9c1ed7f290b89003d098b1d4a61af99271e93ae9"
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
