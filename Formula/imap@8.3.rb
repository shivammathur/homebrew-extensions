# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d6ac533f4fbb040b8fb34b3dd71e2be578d52bca.tar.gz?commit=d6ac533f4fbb040b8fb34b3dd71e2be578d52bca"
  version "8.3.0"
  sha256 "704314b29f230a856f9de1bfa5f582090b6253bb8c434f95237473b482758db5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_monterey: "35af1c1c57a6e0be0f56f6a3f298627bef24c62c2448f567fef9598d5a5ca3e2"
    sha256 cellar: :any,                 arm64_big_sur:  "a50fbafa76c692e14dc47daa4574bc4ea223db35a418a2259418a3b7831dac67"
    sha256 cellar: :any,                 monterey:       "bbf36d94135af3dfd4fe6f9c7ea18c9e5017e4bc994fe586791e33b58acbf53d"
    sha256 cellar: :any,                 big_sur:        "aad474d15b53bb6c0caab11447bb5a929a4df1467157617251beb768ecd4d034"
    sha256 cellar: :any,                 catalina:       "e69ff498844ef15a7f572b51739215a31f212eb3de7cd569ca139668f00a7a94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6f0d69b63e273b321e6b4b70202628eb7c312d5e3ff9f16f0dd862635e1bbdeb"
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
