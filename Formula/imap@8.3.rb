# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2351df39b3d3e61b3edc9e24813f629c4f58e235.tar.gz?commit=2351df39b3d3e61b3edc9e24813f629c4f58e235"
  version "8.3.0"
  sha256 "03fff9b431d00b593cf9f6968ed48e437fd9d9e1f8d4d885249fcf9e90d64837"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_monterey: "7e7ea8da6dc73e8cbc0acf4954a72d97679c223ab8b40c0a22c8d8ffddef33cf"
    sha256 cellar: :any,                 arm64_big_sur:  "d63639bd89803bf61244fb113fae4d76ee53851dbf65a4d5d1e3f789d7241d71"
    sha256 cellar: :any,                 ventura:        "5d77ef6f43daecc9883f5b603ed80edc98adee975b3f33495b30ff4780d6e7d3"
    sha256 cellar: :any,                 monterey:       "378d90caa44467dbc27ce84478b70c63ef0ad7127e3fefc5f5193a75752408ba"
    sha256 cellar: :any,                 big_sur:        "1d9f840a8358a6651611679f780a91d07df6ca37f43ce7104e875b68c82b2b7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "96e3184b5ac2dda2140a83aa73d98134d37cafde4a8824e0b535b05290439639"
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
