# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.1.tar.gz"
  sha256 "7c4ad3d65a5221aacf2428d7062be922ca0090a3bc9000f8bcf4cd98d011ad8f"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "095f2a6d71424064fa745d219f6db3703eed5f062920e08aaeae3bb7cd0b1c6a"
    sha256 cellar: :any,                 arm64_ventura:  "9684abf8d9565a5177d2fc3a25ab15bf229a3a343aa009e718c230f1b4d970bc"
    sha256 cellar: :any,                 arm64_monterey: "9c230537e89088b4bf7dc916d73e3f5da9287e4c415b7c9206ea89c8febec920"
    sha256 cellar: :any,                 ventura:        "a3220544f9fc8171027b96cb0dfd7346fd9ab1b8a11b33427647a4b9587b2157"
    sha256 cellar: :any,                 monterey:       "6338327b796b0461bcac2850e36050013a43d0024f5768a1e534e909a55addc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b0a38a6d2bc353c548730206b857ab2c8ae5a92883f239557135c2b3a5b163a"
  end

  depends_on "brotli"
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
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
