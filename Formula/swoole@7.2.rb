# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  revision 4
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "6e33186ce02bf8b859ac725d872f56045bd275c481e963ecd0308c5c8dd41d93"
    sha256 cellar: :any, arm64_tahoe:       "8d3d1e28dbbd9abe957f127b5e024fcbd965a1f9a3e1a3dd9121dff26c2b9f08"
    sha256 cellar: :any, arm64_sequoia:     "5e5d13a3b09373c52118fa393318322ac5ff2d5ede2c0d0b2bb8a7d8ba0fed2d"
    sha256 cellar: :any, arm64_linux:       "fecc51268f310b72bf3dcbc46a0643e6554fd7e91d7b258a29ae6f31ca23f69b"
    sha256 cellar: :any, x86_64_linux:      "cc01803e5e7fb04237931a3d55838e00e66e45ecb142f67964b381435bf2b4bb"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    args = %W[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
      --enable-sockets
      --enable-swoole
      --enable-swoole-curl
      --enable-swoole-pgsql
      --enable-swoole-odbc=unixodbc
      --enable-swoole-sqlite
      --enable-zstd
    ]
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    inreplace "include/swoole_proxy.h", "#include <string>", "#include <string>\n#include <cstdint>"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
