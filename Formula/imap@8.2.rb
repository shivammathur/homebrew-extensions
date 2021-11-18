# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a8b9dbc632685bfb000615c2599f252b417a61b6.tar.gz?commit=a8b9dbc632685bfb000615c2599f252b417a61b6"
  version "8.2.0"
  sha256 "d609e0391c8a1fa7bc6f53f27a10b469658f999743725deb55f12a1d32c45f7e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_big_sur: "9e757e19f39e9f8cc0d8c3f49f7016bcffe76d4c52cc539f878913dbca44853e"
    sha256 cellar: :any,                 big_sur:       "af4f314a564727bafd81a976c5e436dbd2838cea21c3fd2c9028b9fcf1ddae97"
    sha256 cellar: :any,                 catalina:      "edf815d9d59a70d73f97d9c905cde718b819b3eac5acbae6d2999e009889077f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "499959dea7fcb2702b0be1625b61b1c1447a5e02bc3daaf072db63d60c90caf4"
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
