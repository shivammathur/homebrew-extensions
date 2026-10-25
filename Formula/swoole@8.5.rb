# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "41faaa6bb8b1abb317c6badd228f1fe0f5a2bfdebaf659f3fe3be0eccef13008"
    sha256 cellar: :any, arm64_tahoe:       "8eecf5e59161d3a56b075636b75aac3c386ba6dd9cc420894cc2877238f395de"
    sha256 cellar: :any, arm64_sequoia:     "33d6029ade47563e40913ed138c91c1b0e02e69196e17ebed36be36af003968e"
    sha256 cellar: :any, arm64_linux:       "69c82b28528fd9b3ab0b1833a3eacf1fec9cc44f185c35e00a834a79954585d9"
    sha256 cellar: :any, x86_64_linux:      "5e99b93b7316ba9045b68004679f47c739a7db18dd4fa4883d32fc003a85f67a"
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
