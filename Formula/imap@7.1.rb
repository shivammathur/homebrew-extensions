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
    rebuild 4
    sha256 cellar: :any, arm64_big_sur: "5d70171d29d4566ff522349baead45ea9e0f6568eefb6a5a7fb03cb836254874"
    sha256 cellar: :any, big_sur:       "3be7718adeb345ebe124e15954b3de82c1c3cc3250b7e48b19d95cb649283ac3"
    sha256 cellar: :any, catalina:      "739bffb801d81d7f881509c13dd4b93f3aa86c0dc4633f8b36e86d7cebe76b65"
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
