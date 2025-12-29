# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.6.tar.gz"
  sha256 "7f022cf6fa2f273915fd09f94ef019c50efa06b0be01eaadcb4b289d5622d77b"
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2114ebfa7c596766330f2827099255b30041b6c22d43255b4ccd9852eed3aa96"
    sha256 cellar: :any,                 arm64_sequoia: "d62c61976af13ffff81a39d431aeea854a06301653c985d32bcecbf402123e7e"
    sha256 cellar: :any,                 arm64_sonoma:  "764a7f493613c5074e7313049147a0d81ea179420354ce4482135044bb007885"
    sha256 cellar: :any,                 sonoma:        "e87e4f77bf763441b2892e1b57d82d1b26d2a77cbcb3649fb359d3deb46aafd1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aff0ff88f8a8eb91c4ac7b610785b3a83b6acd05686db0ce8c6d0d5f341712c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6baf1bcdb08d0e2c1caaba6db8331d27473c01994b20aee6824f5fa7efe459a2"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  uses_from_macos "zlib"

  conflicts_with "swow@8.3", because: "both provide coroutine networking extensions"

  def install
    args = %W[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
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
