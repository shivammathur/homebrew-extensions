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
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "db511ce60f98b4c4d56b29a33aa17dd427487bf2a8a321462ec9fe6e90b78fb6"
    sha256 cellar: :any,                 arm64_sequoia: "198bfbfef172483f31d84b634a1c13e300f167cdee648af31eddea046a88478e"
    sha256 cellar: :any,                 arm64_sonoma:  "407c897600499abcfae52d1bcfd068ad710b03798346865b77114521a067bd20"
    sha256 cellar: :any,                 sonoma:        "3ff59f5b022e3344a09fadfeab3078c072ded7737fd438f09d8a1e545b4a65a3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "32c5e7a61c364758082980e209680301358e3206edd981e019aebffdac96a72f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c885495345c9e4ed2524a28a75318b315ef46b6ed2cbcdbe0035cb645d794428"
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

  conflicts_with "swow@8.1", because: "both provide coroutine networking extensions"

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
