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
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "3476a2f885cc43ebbdcb0f7d9229bd047209cff70755bcdb014069f45e561118"
    sha256 cellar: :any, arm64_tahoe:       "3abd2533405330e32148f8816647459f5edd7d145e2faf22d2474e1e04397f62"
    sha256 cellar: :any, arm64_sequoia:     "183dbaeed17448a18f1f9dc5ddfdc9fd358eebb9bf08eb5174927091a822e6d1"
    sha256 cellar: :any, arm64_linux:       "012ee9f105ac1eca8115d041e138214cab4cfbbe88feaa70f2e406137f555151"
    sha256 cellar: :any, x86_64_linux:      "41c854e40f75f5e65b5fa0b97c5e30549537b6a23612c9538660053a6f27e3d2"
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

  conflicts_with "swow@8.3", because: "both provide coroutine networking extensions"

  def install
    inreplace "src/core/misc.cc", "sw_usleep(1000);", "usleep(1000);" if OS.mac?
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
