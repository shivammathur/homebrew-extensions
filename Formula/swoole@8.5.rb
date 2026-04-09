# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.0.tar.gz"
  sha256 "091896ebcdba415a9451b656c3945613e15370a1c7aa6399dfc6b80ebb6fcd7d"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "28eaab53879bea399f85eba21a3e33913d0d75b986363558b0f241454172aa42"
    sha256 cellar: :any,                 arm64_sequoia: "bbcb71f15532acadf5ea416b3aa94a7e0eb668a6ce5fd870b40ca2982ac9a02c"
    sha256 cellar: :any,                 arm64_sonoma:  "a9f779c842b0c9fba39de6bdde2b79b31f487c2ed7de7ede1c29faf9fe03737b"
    sha256 cellar: :any,                 sonoma:        "d994c0d45fbf86d819b02876b5d366fd28ec98905edda6646d10bcdae2760d02"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b6c516112792b58dcc6f084cc6599f2b43788961be140b4a37b2b3f0ecf668f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b461878545fde40bffc91b9266ade8ab93657fd3edfe0be635deca3b10d3c06b"
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
