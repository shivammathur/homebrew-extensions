# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7b4c7374c3d3adfb690d951f5224ba0f27200364.tar.gz?commit=7b4c7374c3d3adfb690d951f5224ba0f27200364"
  version "8.3.0"
  sha256 "363582e78e39d12eb88dace8140ba3198094d2f15528ba8fc64d735ae79575a0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any,                 arm64_monterey: "7156ce9bd25cc7f2016c28695614743d53338a3e9908e3ff1dc32cfa3d15aeac"
    sha256 cellar: :any,                 arm64_big_sur:  "5f9393846ec0dc9e6df7857bdb557876563aab1f7a7e95254b64eba4787318c1"
    sha256 cellar: :any,                 monterey:       "2c310769b6fa7c0fcf477314b646b850d33de4c46484f824526223c0e65a08d8"
    sha256 cellar: :any,                 big_sur:        "abd200f583be847738998983f0199366c0f1f31d5786eb7bc1c1cb7dc8f56cf9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e01570c7754c862cfd2c7bb64a40d90f41a482c4585d404356de6cd793e3fd6d"
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
