# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2f128ea2b2212b5ead79c5f3958dfe0be898bf45.tar.gz"
  version "5.6.40"
  sha256 "e83869bb7ac2cb773d4456ac6409fed55f36779ccc28b2bd8a67228538e4cf4b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_ventura:  "5aab84989f87ae568bb1da5e81bd7ddf87d0b6fc9217e9b615c111bb4249f51d"
    sha256 cellar: :any,                 arm64_monterey: "114b34aa8a4b8f7cb07a2e59c58945b6a54be949443209700cb3080b0253e71e"
    sha256 cellar: :any,                 arm64_big_sur:  "bf969b42ab5fbdb8c760f5c0b05ae34bb593e0d1f329c3870af57f2cf3cae20e"
    sha256 cellar: :any,                 ventura:        "d55f1aead8c7d100950b9edd0dec20170b64815767adf93cfb681aefeeb7dfd1"
    sha256 cellar: :any,                 monterey:       "ae4c0e78c18f111fbf2d27efa2dd40b5c003113f065b834a15e28d23d219c9dd"
    sha256 cellar: :any,                 big_sur:        "55defc42cfdc27bdd28dff965b38c24c3ef860dc5c5c2282dba89fe4530b7efd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5984e175369211d0f765cacc01a1736b337e5f4fa6e14130571b7152545abd4d"
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
