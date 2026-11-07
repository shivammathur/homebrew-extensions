# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "1474f6b213298c9ac09abad9e44287183a2cd2682a72a540348350edf4ee6e60"
    sha256 cellar: :any, arm64_tahoe:       "7f417c5718eeb439c86acd59a919dc9d0b08e931964450cd2a0a1c8e4ac528c1"
    sha256 cellar: :any, arm64_sequoia:     "f9cb693fd68a0f6ba6dda739fd27c10ce9ff3a70e375dd901214447825e93c79"
    sha256 cellar: :any, arm64_linux:       "37779fcd0647f706ebc4dd10d4f6e42539951b8d863e4d5713417d96d4b014b0"
    sha256 cellar: :any, x86_64_linux:      "8885eb20949b6aa93a50e6a642cccc1c7d8eb9662bf320400d97a828950d785f"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@4"
  depends_on "zstd"

  on_linux do
    depends_on "liburing"
    depends_on "zlib-ng-compat"
  end

  conflicts_with "swow@8.5", because: "both provide coroutine networking extensions"

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
    on_linux do
      args << "--enable-iouring"
      args << "--enable-uring-socket"
      args << "--with-liburing-dir=#{Utils::Path.formula_opt_prefix("liburing")}"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
