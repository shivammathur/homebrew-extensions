# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2f5295692fde289f99aa9701528dcde4c78b780f.tar.gz?commit=2f5295692fde289f99aa9701528dcde4c78b780f"
  version "8.2.0"
  sha256 "be5c530f295656c6830d4b97164b012a472f4b792147209f4a9bc24091ad2ede"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 32
    sha256 cellar: :any,                 arm64_big_sur: "0182e03944e871850f219cd44206d0fb7bc882ef98fd6729c5495e58c4667a3b"
    sha256 cellar: :any,                 big_sur:       "e8c0310420ae1ba919c54f888135f87ccfde1a7c1b68d85a68e2cc2f4678d06e"
    sha256 cellar: :any,                 catalina:      "06ccc65df9b12b7d37de1505a5d744b5aef6613b6dff8a396bbf1c4bcf6dc682"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9740689b6f850732d72ac354ae15a4582f563f6974bf3a7d80bea6f0b20f1d3f"
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
