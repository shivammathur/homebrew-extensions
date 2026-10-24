# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.3.tar.gz"
  sha256 "dde8d2a4a6b5c5cd418aedd8561760baad59767a2f8a963b2c0e9eb9c86f4c8d"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"
  revision 2

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "4185cf4b4abaab2a9d42b23c7c7de7050192486dd8dcc9e6da08d3ae77895b50"
    sha256 cellar: :any, arm64_tahoe:       "c7f90d7843f7d7c14a22432a49a379f973031fd92dccabaf9aeab559d214dfb0"
    sha256 cellar: :any, arm64_sequoia:     "f600dfff6325ad57a189524e05309097fb117c5f3b5566e4bdd0e31f6f32c3a2"
    sha256 cellar: :any, arm64_linux:       "d4742dba768c585b5a3435db250cb28df5dc5b35d4d1f3981ae0c5cc258ffddc"
    sha256 cellar: :any, x86_64_linux:      "33b71a5b4cdf1a5ecec2a172e6fce97463c96c215e43588d0e95b01402d0ddc7"
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
    inreplace "src/core/misc.cc", "sw_usleep(1000);", "usleep(1000);" if OS.mac?
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
