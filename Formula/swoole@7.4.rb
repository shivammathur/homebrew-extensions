# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "7d7ca2b027efba35029faa60ede375f4a11c7c974c3e8f970761bd12690026f1"
    sha256 cellar: :any, arm64_tahoe:       "8a6c5b1db71f6d608f5f76f3ff05265c7758d82ea30e62f7b938238ca894508d"
    sha256 cellar: :any, arm64_sequoia:     "dfaa2fc18be911fd954bf3a1989b3c3e63500d5cbaa5fb22d8bab9d723adb993"
    sha256 cellar: :any, arm64_linux:       "791b04f4af956e1581082ca4e36f7bda21209ec36ac9ed5edc0e4a7289f63839"
    sha256 cellar: :any, x86_64_linux:      "48f87cbbcfb3c76776284fed37dab6f1f7c03f5be9e75ab2f85673e0f1ebf98c"
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
    inreplace "include/swoole_proxy.h", "#include <string>", "#include <string>\n#include <cstdint>"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
