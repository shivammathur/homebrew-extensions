# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "5d348ab5b3968961adb39d7b79eb289bdea1b752523ba6b6a975d7a94e7d009a"
    sha256 cellar: :any,                 arm64_sequoia: "f3d9d5668fb844ac51bb342519b93ad0793402a33e056cadedb316f86a1d2209"
    sha256 cellar: :any,                 arm64_sonoma:  "7e8098151067604e938194347b931e80116aa79b3256fac9f353d4cf9e127bd6"
    sha256 cellar: :any,                 sonoma:        "441478ce1eb77774d0cbe94c84892031d3d1d0b01c2ae523d147552e00fbebf0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f346c37d9ba4f985eecaa739ebf5d017d32a66b34b16aa40a2497efa7b370a13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5f16db91efcc7d9fe46a0407f4b843745572bed44012928ce8b7bbdc7837f216"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  uses_from_macos "zlib"

  conflicts_with "swow@8.4", because: "both provide coroutine networking extensions"

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
