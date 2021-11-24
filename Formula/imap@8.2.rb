# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d312a0c8007ffd398cbbb3cf9340db2654513cd6.tar.gz?commit=d312a0c8007ffd398cbbb3cf9340db2654513cd6"
  version "8.2.0"
  sha256 "ab2e4371a03823e93b1de5a6177cdd1de5e99610834e2fb05ee187dc5fc73f3a"
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
