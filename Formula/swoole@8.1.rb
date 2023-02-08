# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5d79f2553b462070e3b4e2616f8cb578a04a5683988ae600e3921477ae032c15"
    sha256 cellar: :any,                 arm64_big_sur:  "a0f94da946abbc2bf4f41256501a9f7cb79540bcb7610f4fff9cf4893c269602"
    sha256 cellar: :any,                 monterey:       "de73a391b4a50add160ba36081fd46c8a01057ef12c556aa8d1c786580e7f0b7"
    sha256 cellar: :any,                 big_sur:        "97ef9991767df5e6af21dbf0ca2c57940b1857ee2d46c222791f121711659acc"
    sha256 cellar: :any,                 catalina:       "199808d9729f3835731e1bc56806fa7dcbd896891ac7bd7156c5125a585145a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "40c5a9af6db2d875ea031eff25335cf2b40081266b1e743ae034d22672bdf77f"
  end

  depends_on "brotli"
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
