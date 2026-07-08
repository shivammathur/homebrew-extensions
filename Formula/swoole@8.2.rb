# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.2.tar.gz"
  sha256 "056703031d052049fac86434b58db0fae3a75804d872871d01ba2e9b82685d31"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "2ff97c9565fde3003f903400339fc1295e58ff21c003ce52f4c2c9d5e9b70a26"
    sha256 cellar: :any, arm64_sequoia: "c305721eb74597da65e4536ff1ff7b25d2052334091d2314e030b7a948bfd348"
    sha256 cellar: :any, arm64_sonoma:  "64b424b27bb68dbea53ac22e3ced2a304a20dc268b2499cd3c7503df9b017787"
    sha256 cellar: :any, sonoma:        "7bd00671ba52aa66d0b432386b2637f1541bc401927004369f203fa4ebf75c48"
    sha256 cellar: :any, arm64_linux:   "094968281502c69d7c980e2f04121936e02f63cee91ae50dceb1288f8404c421"
    sha256 cellar: :any, x86_64_linux:  "3555d7485d93e214be9b00d2613034db3a9b43c0366fd65710433b829d1f71fd"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  conflicts_with "swow@8.2", because: "both provide coroutine networking extensions"

  def install
    args = %W[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
