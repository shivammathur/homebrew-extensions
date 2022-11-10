# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.1.tar.gz"
  sha256 "8db635960f25b8b986f5214b44941f499d61d037867e11e27da108c19dc855c3"
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

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
