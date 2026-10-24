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
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8fe847d6e858e06432c0a9c79091b62900ba7cc61dc303857559bf75cfaec6ad"
    sha256 cellar: :any, arm64_tahoe:       "3a7e862ed27bd6527686635dede74861b949a89d87a542a9de8b8b2a762a5529"
    sha256 cellar: :any, arm64_sequoia:     "f1b53cb038dceddfbe2ea9268285dd3017339c5e4d70bf142d6e440d8caf0c43"
    sha256 cellar: :any, arm64_linux:       "9125fb7ac9c1df536bea8467ee1d9178b824e10d24deb399c1676d41ebf3ec65"
    sha256 cellar: :any, x86_64_linux:      "5daad09923bbd48e044975b6646e632e486350c919023c8b7d55e1d3d316ac8a"
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
