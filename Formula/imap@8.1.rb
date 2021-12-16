# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.1.tar.xz"
  sha256 "33c09d76d0a8bbb5dd930d9dd32e6bfd44e9efcf867563759eb5492c3aff8856"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 37
    sha256 cellar: :any,                 arm64_big_sur: "3e85ab1b00d7118a0ba847fc4d32558e9b2d913601c04fb86160d9cbc5865085"
    sha256 cellar: :any,                 big_sur:       "13948fc2aac7f54a89a15a807f26109b0d2fec79a8a0bca67976e589e9fb18b9"
    sha256 cellar: :any,                 catalina:      "65cbecdc24ca81831c2efa413b1de3c30490a7d88593e904893f2e2ed6cb2a49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "400b2c0bbeeff98c9405340e5c48c263c68f4be8d68aed9fa2cbc147ac22800f"
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
