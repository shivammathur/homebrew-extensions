# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.19.tar.xz"
  sha256 "2126b4b340090282423dd9eeb68a510be8ebb3275b7326c009775bfda3aa848b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c0a7ec0286a795712346cec4e745e5f4f091762fd311f90eb047ba17341108e1"
    sha256 cellar: :any,                 arm64_big_sur:  "3cdc7b4cff82a9c64ccd356e208a4736e070f8732a20f00fd812c0bcfcfec03d"
    sha256 cellar: :any,                 ventura:        "8558ab82f85fc4ec72efa1b53d60fe552ae7388f193e0f369d8685012693d0b1"
    sha256 cellar: :any,                 monterey:       "c2972047ef2cf104f3623a019500d8624ddb703baefd97724c5858863825a858"
    sha256 cellar: :any,                 big_sur:        "34fc92f106fa1f0567e964e0eedb53cd8a3721313f4f07a08549b936591ad530"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8b517d508db7810e6eccfa8ae7a4501e7414e3fab223b81ef7e56920918d390c"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
