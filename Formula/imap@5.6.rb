# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/cfad01ddc65a32fbde3110a84c61d2ac55173a9c.tar.gz"
  version "5.6.40"
  sha256 "2de08c58b35d061f07f23b9dbb9f64f03aef852a60cd331bd9dd9286e71bf568"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_big_sur: "722287809db29d3b2a52afdca878466dc6abb388975641758e538029dc2eb8f1"
    sha256 cellar: :any,                 big_sur:       "1377a864f92221fc6e4f596aeb94f5cf38be78cd29272c9c9b0777a85938d45e"
    sha256 cellar: :any,                 catalina:      "e4759d60deb7c457722c43e0a2bb655a0568d0caade401817b477f31ca7baef6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c5b09181e985e76d516cdea707917ac636fee07fbfc38711222471d5a383045"
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
