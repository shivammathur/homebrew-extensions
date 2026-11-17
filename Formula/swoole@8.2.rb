# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "cdf564139100b5fbf1b3e5873f73af4775b6ff0e0e2dbc5e3981e30c090a6de2"
    sha256 cellar: :any, arm64_tahoe:       "e0d2bebe6eb6d96b049a01481fa92d49dfe2ea7973ba5e77edaeb6c4167e5aca"
    sha256 cellar: :any, arm64_sequoia:     "c7800f44d472af62781128ea2f985dc3046faec5bbe5e661beaedaa403e90f32"
    sha256 cellar: :any, arm64_linux:       "7f4583f89814baa57acc174d0616c14fd0b87ef769b879f7991be30da0a389d6"
    sha256 cellar: :any, x86_64_linux:      "59e9321ceda9683ff64908b5eb255f6d5209a673a4f3d5f9debe1c636bfb4650"
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

  conflicts_with "swow@8.2", because: "both provide coroutine networking extensions"

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
