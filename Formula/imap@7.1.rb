# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dc8d6277d12d445642139b8a7c104898a5a80f80.tar.gz"
  version "7.1.33"
  sha256 "3e7a3342f58ca8698635631993a91541d88e7ddf3335e15194d23dafd5bae409"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "cd1b701b4fe5a8d61b11d7bc1eea8c2544f77329d62ff9dabfe69ff76675ea76"
    sha256 cellar: :any,                 arm64_sonoma:  "60f7aad0ca2b175e1eaee2d7e4a00b7d07e93c891ee05b6c7542afc874459fb9"
    sha256 cellar: :any,                 arm64_ventura: "05ec13be6181ccd8e9ec5d1d58d892f3ea0708a6c6376502e101f955ff4233be"
    sha256 cellar: :any,                 ventura:       "67085e3928cf5c524ea5c130e959ad32561177a86b82b1563e2f03dcd7709951"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7491adc2eaedcc61c0269055d6a5d35bebe61c474272b27dca51ea3bfba93cb4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "198d88f45401daf42737a387543f5ac5420584f38b912f622a93d6b9c2362812"
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
