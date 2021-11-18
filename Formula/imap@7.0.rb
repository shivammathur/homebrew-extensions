# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/271e8b9203ba752de436cb090e3fe8f27c792de4.tar.gz"
  version "7.0.33"
  sha256 "82dfe5cb5ea2040015e9e5a216beb501ecd755a2c3571b4d1b2267cf14ca83dd"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_big_sur: "ebfcafd7e8d4c959bce0246369b5d11b8afc9af7825f5d895f28bd579e710b8b"
    sha256 cellar: :any,                 big_sur:       "79117fcc2f7bed7db5938e8cd50c46a97852f8dbfd3f239811ff4fb653c7f14c"
    sha256 cellar: :any,                 catalina:      "d8aa53b8585bae26fe9a6101a542931c12ffbd64ea24d6b6e417c2cd24f85516"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5f40dd151c7ba817b274f780dc0765975b641125d85357f2beedeeda84d28805"
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
