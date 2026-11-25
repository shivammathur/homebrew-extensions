# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
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
    manifest_sha256 "7673e5d293d7ee37e7a37c94846be38deaee304ed58ce85595df7756686d8d50"
    sha256 cellar: :any, arm64_golden_gate: "ea0697d0a1fff1883206d6f16ef97aa4c735db05c041f2aa494e98cb23f2288d"
    sha256 cellar: :any, arm64_tahoe:       "25903e01030ce499580cfc44d7165ccf3538bfe7778d4cfcf5e7386ac6b36dba"
    sha256 cellar: :any, arm64_sequoia:     "3f2b6d1fd74d793776f2aa614349e6834575d433b085f13ee81ea8daa8ad29d5"
    sha256 cellar: :any, arm64_linux:       "78bc1e03a0367ed9d743e5df761eddfb54c2a6bc3dc515095562e1952d50316c"
    sha256 cellar: :any, x86_64_linux:      "ccb4679922d4a420ebf9d9a704cdc036a3606f947e56e1d2aacfe81ea06fbe97"
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
