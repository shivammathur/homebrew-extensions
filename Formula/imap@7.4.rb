# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5f5f0c7929137acd2cb483a4b288b41fb0cb0fbb.tar.gz"
  version "7.4.33"
  sha256 "7c9de3f869a5ccae677b6a83582d5e5d0c825af22096c4e924c10abe118315f4"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "4966089596e0dd656bb9e02526ed35e9a0d0593edd742da36a1889d5299252c2"
    sha256 cellar: :any,                 arm64_ventura:  "cd054deeb3e73b3166df9e20f3a9b3a6f2df7a4a0a1b20f23de851fe1e4c21e9"
    sha256 cellar: :any,                 arm64_monterey: "1bae56549ccd29c2b49edcc3fa23cc90609537a50bfe854118b6df785199153d"
    sha256 cellar: :any,                 ventura:        "6a4b026cc7d15b8d22ff1199d4b3eebc27749e88ec81326778bc083ca5764839"
    sha256 cellar: :any,                 monterey:       "52a48fc37c379e3ec44aa8c5fdda757b9af5817dc12b77f3d888ab534e877c21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "61add9738f4e2fe910c82fc3e570601ffe4a65dc2032638dd9e37ae183c87032"
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
