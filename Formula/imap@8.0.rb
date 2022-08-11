# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.22.tar.xz"
  sha256 "130937c0fa3050cd33d6c415402f6ccbf0682ae83eb8d39c91164224ddfe57f1"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "65f3d6a61a09600a130ace216871afc8663b4abfb8a79c0100e3dbe4f02d062a"
    sha256 cellar: :any,                 arm64_big_sur:  "8dd1af6582b4f755b8845cb41f8575c6f2a6b88227c795a6b9b62ebf87d2ed1c"
    sha256 cellar: :any,                 monterey:       "544507b721792fb4eafb1aa2c4cb09fd317c239b42b4fdc37ee0221a07ad2180"
    sha256 cellar: :any,                 big_sur:        "95240524e8ec6cbf0cb25068987537086a701ea84d932fcc29c67850c3e24a99"
    sha256 cellar: :any,                 catalina:       "846e3cc68288ede66059ccbbcb5de3d2604ea5d63e75509a22f94e09139b060f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e9c949264322cf50148b2aec21444e1e9f43fbbf74f533cbc772452c97ccfe8d"
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
