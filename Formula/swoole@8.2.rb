# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.3.0.tar.gz"
  sha256 "61f477f6c4515b8b85a9e353cc68298a210521d064e37e734d24a13e68c9a579"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "ee8e43735bc520506c57731b0d794ff3e17d0bdb4be521ebaaf237e44af0320d"
    sha256 cellar: :any, arm64_golden_gate: "ce3fb27e2a668530d701f542dae18c69febc0ba3ea57a2be05b57414e681edc0"
    sha256 cellar: :any, arm64_tahoe:       "46920a890c11a9445abe36a728edf7b17100c4af73293c38fa0b78a866a6fa64"
    sha256 cellar: :any, arm64_sequoia:     "a12bbb0fc400fc546e5bee4f9d701214dd4aaa66970ddd0b5297cbffb7d36c59"
    sha256 cellar: :any, arm64_linux:       "605cbe2970e90d836cffe32707fdd387a48d9c153997265735de27ed2a8e0bfc"
    sha256 cellar: :any, x86_64_linux:      "74476fe75a472ab40b1ce39239491a565f771d11615ef92dba993db14c17d9a0"
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
