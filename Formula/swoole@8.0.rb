# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.6.tar.gz"
  sha256 "0df87a2257f800607d38b6c703789facae5e1d9a9e78cd4a52c3fdc9b6fb64eb"
  revision 4
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c546ed40934ab8e4439782f351984c1e2d5aa28a9b4b711369cef729319f6ef4"
    sha256 cellar: :any, arm64_tahoe:       "7de2d1bd655c8370c22d809b2e2c00528c13687fc44a1e4ed27cd51854f709a6"
    sha256 cellar: :any, arm64_sequoia:     "e067c2cbf14cf82578933efaae6c25768c93ec2eb45404a288c9afd050d078e9"
    sha256 cellar: :any, arm64_linux:       "357f111ccebba6bf8feceacba35c77d1aed96e6eb77b86e22e883f40149c0cd4"
    sha256 cellar: :any, x86_64_linux:      "8db6e91e6449b2f885424e6c7ecc2dd874c9c61b052423441608cfb9b531f6c1"
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

  conflicts_with "swow@8.0", because: "both provide coroutine networking extensions"

  def install
    args = %W[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
