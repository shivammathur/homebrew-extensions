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
  revision 3
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "3fc449d3c464a375cd4c88289b1f3518636427d81964276fbbc841cd2969c601"
    sha256 cellar: :any, arm64_tahoe:       "2999c21c37cb0ffe88d5312d8b465cd978b6d98bb0c1583cb19ba51602e99a52"
    sha256 cellar: :any, arm64_sequoia:     "f7332c0191dd0459e98af30c9c2c0b7d61397bd146e76e46a1711ea91fe4b2f8"
    sha256 cellar: :any, arm64_linux:       "9d9d78b0ac839b5496bbdd65795def9c0e12eb7de36dbe0c91a6d6f14579dcf2"
    sha256 cellar: :any, x86_64_linux:      "f4f189bf2b473233514641a2b19155d9c7792f50f7d6a14c003e241adb720363"
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
