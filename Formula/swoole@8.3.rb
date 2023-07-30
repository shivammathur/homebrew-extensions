# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.3.tar.gz"
  sha256 "c8d82949076aa42834681c738467d7448759ed8174d43a4ba40d8170d6f8da89"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "75f0dbb40b5c0eb18d2cd0a3eaa725b27a0c5384d8648ce7dbe9c975ea37f32a"
    sha256 cellar: :any,                 arm64_big_sur:  "163b0b32438b5afe87b8580f2b96d79916e29f0a152136f591f2e0b5435505e5"
    sha256 cellar: :any,                 ventura:        "46d92ac395de2ef5825a8c8daa0b5096f3f626cf234a6bc77644ebc1b687f5c7"
    sha256 cellar: :any,                 monterey:       "814b6a3600911fd487c1bae4500ce0222eafe5faeeab348f2397c629db642f5f"
    sha256 cellar: :any,                 big_sur:        "dfc671675f35b4070cb9cdc1151c346cd659cac0ccfa4c0a2fdbdf63fe49c0f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a2f193602e3c5bf780c45d7d051d6ce56fd5efd9dbd65d9822cc18381a5f2e6"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
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
