# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.6.tar.gz"
  sha256 "b0a97398d50dc9442d48a71238cafa5f75d2c53d2e35d12a59235f9d52dab718"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "e40645b4654156cce6716c03e3902beacbb99b9e62f1d1cf618abf50c9ff974c"
    sha256 cellar: :any, arm64_tahoe:       "457070a46f1f0afde04d66f3a975bb060492a72daf3c66ed10893d550d31d03b"
    sha256 cellar: :any, arm64_sequoia:     "42a4abde24be62c6df32f5a39c132627e403cabc314ea9bc9f0253c4a1bc3d11"
    sha256 cellar: :any, arm64_linux:       "e1c3febf078ac466b34d94e77b9a02a23f17e65abf14907bbacd5d6a052c7fc8"
    sha256 cellar: :any, x86_64_linux:      "a8c64a1ac52ef40f03d3e9acd4a355a7b0486c7bd384d8047390052192dd710b"
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
