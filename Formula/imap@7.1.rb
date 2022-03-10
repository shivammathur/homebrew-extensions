# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/77410e5d0f8171b6cc5d4beddb8012e38b1fed49.tar.gz"
  version "7.1.33"
  sha256 "9c38535a49a6b837d1710d6a993bca1a8806f5ebbc38a3dfa055c09509bc6882"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_big_sur: "34c8d633b235aa4ba81faee2536b3417cb6c61886073df4f852f7af59c37f03f"
    sha256 cellar: :any,                 big_sur:       "223aeded0ce76c83d772d8a3d8e49351af37ccb6b4fd6ab25d9872eec2e78af4"
    sha256 cellar: :any,                 catalina:      "c49866a2000e88e2474b1f96ad3a2615272c95ba672a45e218ef257601e59b98"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "993b88a5679ce017980eeb47baf5ec5d3ef7a6ab12d67a373394fe824c7a6314"
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
