# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0d94b58d35627770446d2d6dcbb1ffb0817706b4.tar.gz?commit=0d94b58d35627770446d2d6dcbb1ffb0817706b4"
  version "8.4.0"
  sha256 "22cabd4e8c7977417df5405121085180e2364981c92cd5898d30ef78b9344fb2"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "d3d9bb811b1b96d08e0622939f10beb7535043187a727d70e170b64f7fe8d407"
    sha256 cellar: :any,                 arm64_big_sur:  "b30166889aaa0b2af79a7829e20d4f5ba002b6f7a5ca55542353c06eeaf93d4f"
    sha256 cellar: :any,                 ventura:        "f90f0a301bf08a7f1938aeca2ccb2c6cfab685e4989dd76b4f3c4af4878e7483"
    sha256 cellar: :any,                 monterey:       "e05b3f30b30773574bd3bcb2c87d590be88c583c8837a31bb27bb276f6c1d1f5"
    sha256 cellar: :any,                 big_sur:        "eb322d96bd70166c846c0f0a228f7933d5965120892ad9765ea10a1dd8b6f83e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "54af1a2e3382470c36f1c20fc1aba2bb4c3240324d4ab4ad6b269f70d7a202da"
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
