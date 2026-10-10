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
  revision 3
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "e0eed49d0ccfc32579a02022a25d302c25b59492f359b4df897230d69995243e"
    sha256 cellar: :any, arm64_tahoe:       "a3f5a812946e4dd8e04abc8dc0ee8ca6c7c3aa1b5fb5d2d51afefab816a2acfe"
    sha256 cellar: :any, arm64_sequoia:     "53c666593f46adaf08ca5992a5ab0451bd6b8cab2d54f43c1ab7e00287da8889"
    sha256 cellar: :any, arm64_linux:       "168b9aa980087f76ef7a2d45e60830bb09f1a4278efd6499db8ee5b4315c4d92"
    sha256 cellar: :any, x86_64_linux:      "22b41904ac510475ce9ae821cad7e1d2159427eb8ec9cf219fbb1e35b8d02363"
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
