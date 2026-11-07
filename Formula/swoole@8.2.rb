# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "999e885b97bdb49728a5b1b2d9eb2f47b83a94b1b4e762c7c252de451ddd03fc"
    sha256 cellar: :any, arm64_tahoe:       "180151e7af144810fd0537001456518c0e7f949a476a062aa1e196cb3fe1db2b"
    sha256 cellar: :any, arm64_sequoia:     "8a079ce1bf9632fcc9fc88267c088b7482cad051e4d048582654ae8720610683"
    sha256 cellar: :any, arm64_linux:       "eff5ade136cd2dfaaf3af27c3da91b2d0fa9ff1bfe59ade42e57cd43ec5fe6dd"
    sha256 cellar: :any, x86_64_linux:      "9ce3a9fc0a185e506a416589ee135172c84dddb07c8c97ab69f88c96854c6ba5"
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

  conflicts_with "swow@8.2", because: "both provide coroutine networking extensions"

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
