# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/b132b7ab7efb40628dedf2eae1cf7d6949684bcb.tar.gz?commit=b132b7ab7efb40628dedf2eae1cf7d6949684bcb"
  version "8.3.0"
  sha256 "6543ba2ba14df85657e0821edc232f000dc73d1330e8b7c2802d23d21c22f4af"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 44
    sha256 cellar: :any,                 arm64_monterey: "23d480a3ea98893c5db3bc43cbef50f6332fa1e996dda484bc249284b1bb0c99"
    sha256 cellar: :any,                 arm64_big_sur:  "106983ff0c7c7eef10e488ecb49fcccfbfc98b564b586bae8ccdac677b35c67f"
    sha256 cellar: :any,                 ventura:        "e6fa7ef4d28f3e9c6490da5331a5e5850de581ae6782104c1986f4318b725ab9"
    sha256 cellar: :any,                 monterey:       "0b7f5d9c6bc7aba17308b0a7bbfcdeb92b369c0fbedb778563b870c6f21d0325"
    sha256 cellar: :any,                 big_sur:        "49920acccd702068cb4be5ff5b7f5ba743302d056fbe215442a8927be50afc89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "12fe1a39a04bf07ad2be8523ad85110975741569b6699fed309a7c8ddb69b064"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
