# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.3.tar.gz"
  sha256 "dde8d2a4a6b5c5cd418aedd8561760baad59767a2f8a963b2c0e9eb9c86f4c8d"
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "7d39281a856f3eb86965d96b645b6849d2cfed0fe2ef78052ba6f3daae607d1c"
    sha256 cellar: :any, arm64_tahoe:       "cb5605a5c9b01b1ac4a5d59e3b9aabc02cc74c0b490d6737b1cdf1e7a6da0365"
    sha256 cellar: :any, arm64_sequoia:     "172839f514ad1dd7989a3f42d1a6df6e27043fcd178991938dc4d3cada5dc258"
    sha256 cellar: :any, arm64_linux:       "fde193e12f4e716b33625035681e79ebece85c2ea0c19e0319f46bd877bac3d5"
    sha256 cellar: :any, x86_64_linux:      "579fec078292ddb66ecb5d21c40d75f75f56dff07c5faa51f4d6d5c59718596c"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
