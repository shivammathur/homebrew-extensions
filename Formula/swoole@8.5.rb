# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.0-rc1.tar.gz"
  sha256 "a38edfa6a8f07c472ba1533756cd5b42f177572359e8841081c5335b7998641c"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fb8293965635411e85475081a2c575ccb6abb61589e3f8b50b022bf42601a655"
    sha256 cellar: :any,                 arm64_sequoia: "35339372927e779d6b8556af82f0e4629cda9d12e3f07c978c2d0d0b67976835"
    sha256 cellar: :any,                 arm64_sonoma:  "2922ad48700368108071ce1df2730bf44df5657cc4579ba3db598503bea0bf15"
    sha256 cellar: :any,                 sonoma:        "5ff9d41eb3af506a748ad024bbccd88761d7a71762c03906dbae96c8f5bdc466"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cf2f2475a63377dbc8c8227868a28730d5b80da3741250feb8565b5ffe5ef563"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c08ab4200af0d64db93865d37a74d986e5a0935e52a97aa6ed9ec74e4f2c540f"
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
