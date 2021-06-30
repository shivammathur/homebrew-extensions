# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.0.33.tar.gz?commit=4faea6cc54c742245639ba2736b199c711f2a77b"
  sha256 "bb131e2ee1b1dd26fa80894cbeeaaadb93f880d5427de96059cd526d5e484ece"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "bfb6ff6c89216c5c7a92250c79a9c6d1f8e9c9e36c6b23788bdc4d2dd8d2fa95"
    sha256 big_sur:       "f6de48a58bfaedbdc27b590da82b1f08460308a42ff8f6d74bb74be0b0dc13f0"
    sha256 catalina:      "3c3c3a6f2d62353def30be50cc00e0a05886a43fc5fcfff10d38b92401b4250b"
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
