# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "6265bfff800be23786209a725fc3d97155247902cf3fefba526de5cca882a974"
    sha256 cellar: :any, arm64_tahoe:       "7fa0181262d38689f1208d5d5264504f3171cd5b7c657e65b01b39b388e7ce9c"
    sha256 cellar: :any, arm64_sequoia:     "2d18429d2fd2d74d6661527ccd64655587fe64f02b455622ae794e9eaf7cf08e"
    sha256 cellar: :any, arm64_linux:       "a1eeb4f2a19baba751fb139b6ca1ab4a4a588ceb573de4caf139b4f59d543803"
    sha256 cellar: :any, x86_64_linux:      "88ababe816b2f1f12f6aab56497ffe7aea5cbeb5cd8c31783e7fe15ba8101d90"
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
