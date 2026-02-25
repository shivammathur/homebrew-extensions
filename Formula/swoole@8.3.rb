# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.7.tar.gz"
  sha256 "46c8d9bcd1c972fe71a7aead3e43e1bcecde2d8390b393413d139f0a7486b8e9"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "0ffb2bbf3858ee420d80e3205ddfc2d7e96416f17672b84cffa9a39ac490b730"
    sha256 cellar: :any,                 arm64_sequoia: "f835fccc60bb25320ad0484b196bd82f248191e0053c4e1ca7854be719b56df3"
    sha256 cellar: :any,                 arm64_sonoma:  "df13e1a8821791da9e7708eca14161b1ac63564b5d15d05c8730f6dd38eb919e"
    sha256 cellar: :any,                 sonoma:        "000ce3de6676a836b9debed12a620eb5ab7fbb350d25a2ac8156b13367fe77e4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "15bfd117532c939dbe6b717a5f7b152777f10d6b39583563c8e00fd4f3c297d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "efac20a6fb0bda165468005b4dc81838c928d7d64b56562d5d519eab2c655832"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  on_linux do
    depends_on "zlib-ng-compat"
  end

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
