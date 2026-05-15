# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.1.tar.gz"
  sha256 "4b16aed387ca0eae52b59065492788fd6a748ce64467a08c6160dd524fcff626"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "0d7aa3559ce8926b7900b7c25e990f428b0c559114c2028803dca74b4481adaf"
    sha256 cellar: :any,                 arm64_sequoia: "b62785309a14b7a2b9cfa8572394bcd6dbe597353792970d0dc2654b37db1d75"
    sha256 cellar: :any,                 arm64_sonoma:  "f097a1527e5175fa73dddff8cf8bd8bb108a6ce9e6ecfbebf8e160938111fc04"
    sha256 cellar: :any,                 sonoma:        "d5c308bdcf27af69a64142e1c757d13c52edc32e0fbc9b87a4f0063ee16aa67b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1e3ecdb185155a2414a9b093ca5a7d47b2c947ce33777be1e74123665601b1ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6d2d73ba633af152a380ca44181f4a98bcc1a85d90eee1efff9aa99ac021ee14"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  on_linux do
    depends_on "liburing"
    depends_on "zlib-ng-compat"
  end

  conflicts_with "swow@8.5", because: "both provide coroutine networking extensions"

  def install
    args = %W[
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
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    on_linux do
      args << "--enable-iouring"
      args << "--enable-uring-socket"
      args << "--with-liburing-dir=#{Formula["liburing"].opt_prefix}"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
