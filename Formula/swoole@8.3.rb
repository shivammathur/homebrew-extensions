# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.3.tar.gz"
  sha256 "dc7a24094fe86025de4a0fed2a94005d2266a29332e7e9e6be50238a8ef6cafb"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "f350bf03cacdf63e5a4ce8f92725d8be809f084daa08fbe55d7ad9814dbe5c30"
    sha256 cellar: :any,                 arm64_ventura:  "d4453494f937c7a4efc90b9f38eb75b0ce03ec479a78efdc8b9fed4f1612a15f"
    sha256 cellar: :any,                 arm64_monterey: "e4acda9d5fba18e3675b783e76cd50bbe1648e6c1cbca1941055b12983dfbc11"
    sha256 cellar: :any,                 ventura:        "e2b1d9f820f0d43e057f7cd1da62e8f38ba6fb4a87f7cef06f3af1da29055653"
    sha256 cellar: :any,                 monterey:       "7564a8bcae1b8c90b583073b4877c6e9cbf4eb6550db932d027c86c4d3ce927e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "918462efd446923dea514f41883a7c80ee5369083106b701e70dd71756f0c918"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --enable-swoole-curl
      --enable-http2
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
