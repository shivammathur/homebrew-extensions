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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "bced3eb49d35f546a9d6026a064993d1b052ce0ff1b2c2fe9e3f42dc2f221ce3"
    sha256 cellar: :any,                 arm64_big_sur:  "ad98d453ca876887596df47889ffcee170144c3b72ea8a3dc2b2b890c1da16bd"
    sha256 cellar: :any,                 ventura:        "3f8b7f2b773e56f79d47aad583e700f38bf4d7d14978bce0d5d9b0d160b41389"
    sha256 cellar: :any,                 monterey:       "166d5d4bc4ae43e53737c7079735cc5846db4c6fbc69a96d9f7f3d8e595e9e17"
    sha256 cellar: :any,                 big_sur:        "377fc65e7ce1cfaf9509ac48cebe503afd80a07fdb752184e120d8333b587875"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "533fbd4b387eacbfd4777d71cd69e4b6c9163bccfee52d101583eb540c0c6859"
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
