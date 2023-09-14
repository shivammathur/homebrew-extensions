# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/789867e844dc0465fe01a703a1bef2a7dba0c62b.tar.gz?commit=789867e844dc0465fe01a703a1bef2a7dba0c62b"
  version "8.4.0"
  sha256 "50d54b44e79ead9c0d63a0224328a06f2988c82e73f0fb46b6aba3bc30463dde"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "4dd4ce73eddc871f0259b47b01cfcc35161853764c56d28e4a94defeeb32598d"
    sha256 cellar: :any,                 arm64_big_sur:  "d5788cf93657e42c57afbc3d5fdf4260da2298e58a8b76872ce0797bd303c3e6"
    sha256 cellar: :any,                 ventura:        "fc9736600702f9cabc36bf2cf12d20881e7ecf38c80c9b93d7d2c60a62e7940b"
    sha256 cellar: :any,                 monterey:       "3613c99d9dca3ab4546cd2f98dcb426e81fc39c2d4db2bd7d9eaedc6cc5548ce"
    sha256 cellar: :any,                 big_sur:        "edda4f5cd06f138c4857c758015bc22491f8e16525d878848bae7427fea357bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0540e2c3b445b6bd320ca2b28f0986fd5614e3bed1f26d43d56d9c24c8be5d19"
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
