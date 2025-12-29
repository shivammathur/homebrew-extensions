# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "768cf4001933551674514006919a5c70de3a5d325149c9a76ec9aedef00c0ad4"
    sha256 cellar: :any,                 arm64_sequoia: "4f9a958055c1df80ae27fc69344c76d50f270d4b518b0e6ae0379852a39a2cb2"
    sha256 cellar: :any,                 arm64_sonoma:  "7dbfe54d8367fc116bcd0608a7de0a3d33a52f6e90b8caf1fcac35b380782c8d"
    sha256 cellar: :any,                 sonoma:        "371a2ca55641b7600cc1cd12aeffac082c7825fae6ba2e63dce0c323252d4e45"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9eba2c105349cfe9af9325b461da8bf11c42be50451aa52f2ca3148ab391162c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "55b832a35556e69805976a0ec146a021d9c9b37f237f281546303bab05cfc4a0"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "openssl@3"

  uses_from_macos "zlib"

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
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
