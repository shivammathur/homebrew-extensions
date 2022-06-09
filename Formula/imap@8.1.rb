# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.7.tar.xz"
  sha256 "f042322f1b5a9f7c2decb84b7086ef676896c2f7178739b9672afafa964ed0e5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9b453c15b301eb81f8601455a62f3c3f077d452307d5c55c7f10d6c33560f5c4"
    sha256 cellar: :any,                 arm64_big_sur:  "a8a0f707cce648b1e9a03c151769a9d5ca47b56c3f7fccc1105efe57f528ef1a"
    sha256 cellar: :any,                 monterey:       "9622b1502eb6fb9281e2cd0a991ce705959a16d3c540ac8bf1d92d6efd342ba3"
    sha256 cellar: :any,                 big_sur:        "e704b6cfff1ef2605db3c3eb0e43d4a2b964b3223c438e390fa9cc0cdd0b67a2"
    sha256 cellar: :any,                 catalina:       "c0689bc13baaeb7ea32c5a929606b5c064899c52beb1cd92191643ec45915a46"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b17668a437928f072e66f5760a3d47c11eff8b93693be1ce195b63f10c7ec518"
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
