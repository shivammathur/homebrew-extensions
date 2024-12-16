# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9d5dc7ec3c99d9463d9086d37bdfa00f4978595c.tar.gz"
  version "7.4.33"
  sha256 "8bc8e205e3016421c51562919ae0f52bd275a9d9e8d1d135b5b2418f05958f24"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "3ed61459e9a9760c3e2c8311d918ff906c08558564dc84dea2fd94e61b1a7d58"
    sha256 cellar: :any,                 arm64_sonoma:  "fa90a775e82983fdc0bc37c21b1b621f9a9a4ab3ed93493a1ac0c0b031a26cf9"
    sha256 cellar: :any,                 arm64_ventura: "a5c6af1ada1096f76628f3c582a48bbf18b3be090b6bd7bcc40fd3354f075c2e"
    sha256 cellar: :any,                 ventura:       "f2710d852470e79f0352ab969d1e08507aaf10740c0d312ea57b1449acf3a245"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa540d922e0b6f356f7b832ef8a3628323981f348f4fb9391ba9dfe4a0c1fc60"
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
