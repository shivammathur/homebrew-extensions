# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.4.tar.gz"
  sha256 "92624681feb1b1311a4ee0fc40080e747b63fc5d0ed988f8e6aa148aac55987f"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "79cb01b6c4f668ed1c9b98683e3e07697e0db521ed52ab5cd5f73ec6b6692919"
    sha256 cellar: :any, arm64_tahoe:       "fd454389c374b9742b7ecde94cde3b1d2da19e971edf3786364a00f41ca11e91"
    sha256 cellar: :any, arm64_sequoia:     "320b08040f042447d04696b0ff30a10d67c07ed02e5269da276f5d7864ed4ec8"
    sha256 cellar: :any, arm64_linux:       "6c58d4bd641e28040034376f6a708090495d6ea2e26b50daa569f8fb1588ecc9"
    sha256 cellar: :any, x86_64_linux:      "13aced8d00d2edd959dfe7a8c7bb3a1899b4950c14d07771644ba4b382e91ead"
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

  conflicts_with "swow@8.4", because: "both provide coroutine networking extensions"

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
