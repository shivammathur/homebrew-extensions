# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/669495675ccbd128259246aad81fd86d296ce029.tar.gz"
  version "5.6.40"
  sha256 "c5c3cc8594d73d4fb730ed767b81a05ae9a569b337cc4973d1e777a2f97fad5b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_monterey: "c0291360e1cc42e247f8e1afeb5a49f1d5add09e58414b6590c8ac9e34c1193d"
    sha256 cellar: :any,                 arm64_big_sur:  "63ec83a3eb4fc48371bfd872474bdec1662ed09dcb4aee98e6d579ab73c8c153"
    sha256 cellar: :any,                 monterey:       "d358f0840eff39dc52c92ea2e2cabf98ae9082021123a5f4cb7cbb3319dfc8e6"
    sha256 cellar: :any,                 big_sur:        "e09f2e10ec91d912033b17678499d5b198886f3193d02fb83e554efa62479d59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7822faf3e5a7b6a2909cd0daf638721f0efe053c9dd6da30130a29ee61d0545"
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
