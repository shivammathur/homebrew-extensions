# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "d3fe7f2aa7def9ade91fa1439c7391b8a44583e9456bfd1562a90214129a2865"
    sha256 cellar: :any, arm64_tahoe:       "e0a80808cac5bcf9933bfa7f1f68f6fac6d66220339d8e8209999e71bae61a59"
    sha256 cellar: :any, arm64_sequoia:     "3368ec985dcbf37266ff011ba0b6647d8b7d8e4494ab0b7442632b7e4ecf9ba0"
    sha256 cellar: :any, arm64_linux:       "42a2a31238616b7a26a501e0039eaf494f6348a32ab387e986bed824a4914c08"
    sha256 cellar: :any, x86_64_linux:      "6f72a2be737aa3abc0c3a620a542b1eaf0f67b1e57a40598c01381e9ca88d8b2"
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
