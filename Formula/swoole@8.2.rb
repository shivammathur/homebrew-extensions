# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "628cfea777841bb8754eeec24a39c03b9385bcc3af68b7206d6093af50083ac6"
    sha256 cellar: :any, arm64_tahoe:       "6ae1d88fd004ee7d28b56d796b142badb22e8e60d11da95fbf6ba7fe3c3e18b0"
    sha256 cellar: :any, arm64_sequoia:     "8bf977693347c3d73c76bf0cf7c5a757601c762c04376a1a74644784b4dc36f4"
    sha256 cellar: :any, arm64_linux:       "cc48377fc8e915f1315bb14a5853cce505315c333b5dd6c1a825392a375db395"
    sha256 cellar: :any, x86_64_linux:      "7899409e8c1753e02c630f18032bbc940dd596bd2a162b57a0b6aeda51baf5b4"
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
