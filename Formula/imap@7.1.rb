# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e7c01a16aa91e459b93bb4fdb19f88764e006e58.tar.gz"
  version "7.1.33"
  sha256 "47da6ea441e2e61069a7456f5e098d91ef97ffc1f81f5817550eec5a3cb0f36f"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "98d9e7314bc7efdf57011d4f1379d27fbe6003c272033feab93d90780c686bb4"
    sha256 cellar: :any,                 arm64_big_sur:  "9faf4f6cc47adc127867d1ccb988f6f8b97097cf782742254b88bef2573f4d80"
    sha256 cellar: :any,                 ventura:        "812723c50aa0d480d06e60ed8bfda86ff29150642e058e98d7735c031f653e44"
    sha256 cellar: :any,                 monterey:       "e0cbf3be3da8d604fd138c2ea3032a1b9dee1e45776f52d849c6493ecf76db9f"
    sha256 cellar: :any,                 big_sur:        "4e2f15cd6e8485fa28e45b9c4ef5a14739ec6412a69ff8b367af2e7ed3846312"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f234ec4aea9b19fccb4e121d1c9686a4f5bc26276bed45b42e509e36e2c3f714"
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
