# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6f6fedcb46a27cd3530f0babc9b03ce4598f9eab.tar.gz?commit=6f6fedcb46a27cd3530f0babc9b03ce4598f9eab"
  version "8.3.0"
  sha256 "7c2889c5e12332db85724204c5891a221aa32faa0226078018d752e187f7b413"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "d3e0da2fee7ef82111db2cb27eabbd4731968580b1aed2a274736d17309b35ba"
    sha256 cellar: :any,                 arm64_big_sur:  "aabe7ea985aa7b879b162656fc13cc5cb5de2cb6c60c0085611c8c09f8aa42ca"
    sha256 cellar: :any,                 ventura:        "0d9cb5f6c09f7376c5e23dc728b2b875334f9ffb5ae33e89d52fbcdd6d13abaf"
    sha256 cellar: :any,                 monterey:       "06b13209cb2cb46b63e6ce7a7f7ea61c97baa5acc767e1c617ebd93086f73464"
    sha256 cellar: :any,                 big_sur:        "15e38fb4d55cf7b6d86bea94954769e745e493a9a67c253a2513dc34e5da2172"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "77f36884cc12b1fe700c7caa82284d5ade5d6cbd2f2cfebd3889a39919dfaee6"
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
