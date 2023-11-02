# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5e12756ee8e1682149440494b4aed81af182fdb8.tar.gz?commit=5e12756ee8e1682149440494b4aed81af182fdb8"
  version "8.3.0"
  sha256 "d85a243e1af1d40279377207efd95578834cc0633aa2206ed41aa7124fdca5ef"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_sonoma:   "2c179cb3e84b69d2a2c0b0ff1c27b566c9d7a2c99d962adc8be682acfded1685"
    sha256 cellar: :any,                 arm64_ventura:  "3084ba8756371ed7e4b4d6b7c89c5894e6131db65115fc20c97a2ca62d8dc52e"
    sha256 cellar: :any,                 arm64_monterey: "1bdfd41470c733eadfe7c25113683152b9bb87e07d0ce62706656972f2bda4ec"
    sha256 cellar: :any,                 ventura:        "99db1e94c495518e53087c21ce86a6c730b7c377412f0d869782366cd82d1a1b"
    sha256 cellar: :any,                 monterey:       "fb3b4482a857c794a91959156c5cad3a000ab1433c7724944aacec5f5b52202a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "70d3e0be88a02c4769fbd08a5dea20e05dfb9d8b311fbc7187e3b86660e7d157"
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
