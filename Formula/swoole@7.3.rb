# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "3de9aead7d7f2f63818f71a96be7c8239f8dbac3f79defdec540403f6c15907b"
    sha256 cellar: :any, arm64_tahoe:       "8130267885ac7eab1701a4bd33c1b4dd02292f9586e3fbbcf0dc20df363b9899"
    sha256 cellar: :any, arm64_sequoia:     "c96b039940fe19a4c37f3f88f839f8c68cc2166dd161087fe7d6b1fd3ca76d6d"
    sha256 cellar: :any, arm64_linux:       "ecca9de443ee25b7acb2b9cac52713df1ce8b16c0e36d33a511b1c2eef6fcf4c"
    sha256 cellar: :any, x86_64_linux:      "33ae28531d35e4a9fcfd88717c182e7f51c6e91852f1545a31667173babc877d"
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
