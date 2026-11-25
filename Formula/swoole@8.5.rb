# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.3.0.tar.gz"
  sha256 "61f477f6c4515b8b85a9e353cc68298a210521d064e37e734d24a13e68c9a579"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "a3a8acf3bcd5238f4d787c53e81d256651e24822621e880edd05f1d17fc3fede"
    sha256 cellar: :any, arm64_golden_gate: "ad181b5952e741642aabccedebe89211885ce8f4d37851f686c8ba84cc5a8cad"
    sha256 cellar: :any, arm64_tahoe:       "0ae9c27063daa8c192de63f895749ce4cb24da9ceb17ed5c73917a0c0f3fb605"
    sha256 cellar: :any, arm64_sequoia:     "abb0871ef4227380c68e1d3aae748668fc53dfcac53eb2677135f7ec14a307c1"
    sha256 cellar: :any, arm64_linux:       "744f8ea7418b3a301cd3f7b180d61b9c81cdf15a40695e057c5917061ee9d936"
    sha256 cellar: :any, x86_64_linux:      "1c0cb5e03c88ecfe22d9f1d50b69c16189b60f0362e0e6ae37fddd954ee5d1a6"
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
