# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.5.tar.gz"
  sha256 "8b8261162375a04a1fc58775824ca146ac1d1905c178fbb548381c27f2c343f5"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "b6dd2cb41ac667c523e2d5affccc831d743935453ced28c8d2be4fb815de112f"
    sha256 cellar: :any, arm64_tahoe:       "c3911c0fd64a8dff93cf2d03321e0c9b07ea920c4dc59df6efbedc30143ac02b"
    sha256 cellar: :any, arm64_sequoia:     "9dd3acc773db1d6a416152bd3f6503827548f46c5fd0881c0fe6303bb8cd535e"
    sha256 cellar: :any, arm64_linux:       "eb000069ae55b9582b5e582c82dc25a12dafc4e49fac19323c9e63c2fa4f2140"
    sha256 cellar: :any, x86_64_linux:      "0d5640fd10536fdcc6d15f3b861f750dc30e872f5594a3e80331059a12ae688d"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@4"
  depends_on "zstd"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  conflicts_with "swow@8.3", because: "both provide coroutine networking extensions"

  def install
    args = %w[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-sockets
      --enable-swoole
      --enable-swoole-curl
      --enable-swoole-pgsql
      --enable-swoole-odbc=unixodbc
      --enable-swoole-sqlite
      --enable-zstd
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
