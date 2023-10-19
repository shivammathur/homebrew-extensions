# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/221b4fe246e62c5d59f617ee4cbe6fd4c614fb5a.tar.gz?commit=221b4fe246e62c5d59f617ee4cbe6fd4c614fb5a"
  version "8.4.0"
  sha256 "aa4bbae2504daf8c2e1b9ac781a44ea179f208feb762990a49907edeaaf9266d"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "97e89851a32a00696ee4769cd005ab7352b7ec217d643dab4d022652cb075cbd"
    sha256 cellar: :any,                 arm64_ventura:  "f9f9d3fa6e6535e6a652b19b471e1a91be29f8dd12cb5e2aa8a02c07273addad"
    sha256 cellar: :any,                 arm64_monterey: "169b18fefafad95dfdebaf079b09faa08d7203efb43077a0df110c502d435c5f"
    sha256 cellar: :any,                 ventura:        "ecde069a84ad37b7e5d5582f4914fd02708642deaa2bf33a8c228fef4c0dbe6e"
    sha256 cellar: :any,                 monterey:       "7051003484cb70ad21fdea9d44c29c6ab5a542c63c42ea90e57c36bca4ddbc9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fd7425b9ee02e4eaf257e7cd6c71e2b95e3cb15180cf40fa31b2c7c21d92499c"
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
