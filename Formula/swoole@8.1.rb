# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.7.tar.gz"
  sha256 "46c8d9bcd1c972fe71a7aead3e43e1bcecde2d8390b393413d139f0a7486b8e9"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "759a5e195ee2e961af5935e2f8e7baee7651e697599d4ecfb61cefe4cab0a5a2"
    sha256 cellar: :any, arm64_tahoe:       "7c3831954198741827d9ad219476104d2c6ac29b723d63f0074a1c1f6292843e"
    sha256 cellar: :any, arm64_sequoia:     "a1a861a59360c8c48a6720077b3178802d42ca6d27a1814cd9127af4ff40d970"
    sha256 cellar: :any, arm64_linux:       "5c7ef9a42a315f7b6c84c91677a41896295502b957a87d2a53d893c05d160439"
    sha256 cellar: :any, x86_64_linux:      "b9756efffa5c1f6da2da95afc2ed8b3039818de2c0eec0930d9a46a5f8e4f991"
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

  conflicts_with "swow@8.1", because: "both provide coroutine networking extensions"

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
