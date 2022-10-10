# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/182c8acf432c25150067f6224faacaafd5d9b8b4.tar.gz?commit=182c8acf432c25150067f6224faacaafd5d9b8b4"
  version "8.2.0"
  sha256 "1b60d8e8a89c286537ba1111caf792df4a61fceb5d6d1489b0e0445f03d0cf7f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 75
    sha256 cellar: :any,                 arm64_monterey: "7723beee63ab6c0f167be93b663c1e13a3619c6ad2d02dd7b37ccdeb23ad1ae3"
    sha256 cellar: :any,                 arm64_big_sur:  "a4b90a0e7b5f84534fef3bf1f56a485a7a1b7427b89bb6cf47709111d479e6c6"
    sha256 cellar: :any,                 monterey:       "b2e9a53b13ce44121ed9a85a8d4f83960676c5d55ec7bd5cc24a0addc7c8a7cb"
    sha256 cellar: :any,                 big_sur:        "15aab7f96fccf2b7fa91eea6d0a49a47b55e6eef5304a0c1792387f07f90ab6d"
    sha256 cellar: :any,                 catalina:       "7ac7686fa5975244c1479dcd8a3066043f815e30bc5db08d6e050f6c520dbd18"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3751cd7a87d9a67582dab7ba73c659fd82b60a0ae8eb0a2eee094cf2943efcd3"
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
