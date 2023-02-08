# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "1a5bbf7f6ebe6dc19910d72955fe41796ca80abf6e2754f4a49cff7e01d54e7c"
    sha256 cellar: :any,                 arm64_big_sur:  "f9bfafac2a225cd0374634c94c4d82d996835e2661397dafc71ec206b3fb46dd"
    sha256 cellar: :any,                 monterey:       "f4d9a4b17bf5277f1bd7b7b8fe7d51c621e65f89ab083d0037abe16cda452e4a"
    sha256 cellar: :any,                 big_sur:        "a9822b8d09038caa1705209c988fffcf38a0294de1cbb559c7b3d6b610800d69"
    sha256 cellar: :any,                 catalina:       "7a188c0f6f332cb8dbd7297da5d308116c2c590aac62f70fa658b6d1d7a0ef9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0648f4da0be7215ba4075f630136e543a5315b9ce690c41b6910de057785b1cf"
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
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
