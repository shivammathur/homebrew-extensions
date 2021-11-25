# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/cddb65b54e9ca0d4869c4503113c9b7aa9bd2980.tar.gz?commit=cddb65b54e9ca0d4869c4503113c9b7aa9bd2980"
  version "8.2.0"
  sha256 "9cb05b6f7933e507065c63869f28f14d817a02134db13d1b398ce39c08ba0fe5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_big_sur: "775cf1c7053d808421ad2b6ea205ef062d545db7a8a9b300417aac66609cce9e"
    sha256 cellar: :any,                 big_sur:       "b26453251aeb67e625fde0bc6d73dc24ed3a368e960b6f5709594177f4ebca59"
    sha256 cellar: :any,                 catalina:      "32a94091fd46b57f3adab2afd83502befadcadb6e41d132248fbc13a316d190b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2972c545e7a01b85c60e77fb54b84aae77789f3ed41b18cbfe248c33c15bd0a7"
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
