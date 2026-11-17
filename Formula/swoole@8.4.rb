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
    sha256 cellar: :any, arm64_golden_gate: "035d539d9386a17ef7477c010a8d07fc8f5d211988e784e7e213ca48b690251d"
    sha256 cellar: :any, arm64_tahoe:       "84171362d0b90bfb661b3ac15ef6d93595153f213a7d344804fe2ffb8c0eae8d"
    sha256 cellar: :any, arm64_sequoia:     "dee17be06bd574d2d9d37ed62f8ea0d432790a62f9b1ef7efbd451137f28c708"
    sha256 cellar: :any, arm64_linux:       "d65a620439ac46182f8c2ed4b5006b41ef22ef1362704c504633bbe9791ea4b7"
    sha256 cellar: :any, x86_64_linux:      "11ba0ac33af1254948e202ec9d7cdc49a2af608c5a575d02f1e2e28b2f70f3c6"
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
