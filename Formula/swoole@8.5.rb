# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/2fd8ea4c07899ef8bac028c9d7b18fb1cd0092d2.tar.gz"
  sha256 "bd3eb3486fae5484e59f61e96f1448b90ec47527befc7d558baad50e285576d6"
  version "6.1.6"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_tahoe:   "977909d76c6ee4e22613399dceca56de230669732320dd40ec9207164fd5f1d6"
    sha256 cellar: :any,                 arm64_sequoia: "a5cf9d05ccf7c34f0f3249fbed860784505d9a6ac7ef1e58dda0f1dbec04f362"
    sha256 cellar: :any,                 arm64_sonoma:  "4fa0ab7a0041aa27db49bc83d2cd5d497cd974a6cfa1ca0bb9452849a4ae3e8a"
    sha256 cellar: :any,                 sonoma:        "aa547a147fd92dad594c4f02ffc0fac34dc02818eecfe91c5262ef443b02dc01"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "affe142a8f42af6396b8459a141cc50b96098e30ce4965e6b8aed8e0715337fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e548a5c89ffa263593701be60c1260409af75fa7ca393df6aa5927bc13af762c"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  on_linux do
    depends_on "liburing"
    depends_on "zlib-ng-compat"
  end

  conflicts_with "swow@8.5", because: "both provide coroutine networking extensions"

  def install
    args = %W[
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
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    on_linux do
      args << "--enable-iouring"
      args << "--enable-uring-socket"
      args << "--with-liburing-dir=#{Formula["liburing"].opt_prefix}"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
