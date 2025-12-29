# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "bbef14c63ca80cb969696d4faec6c0e88476056b7267457a10859288b1aa3d34"
    sha256 cellar: :any,                 arm64_sequoia: "867e7197663e9c43d9d3b4fa5c93ff0617da92c0fd895114e3558670c46ea519"
    sha256 cellar: :any,                 arm64_sonoma:  "9f2dec7bd02d409fa47ce1a8d4d035a250ffaf1a00d0f5e53048b98229c7327d"
    sha256 cellar: :any,                 sonoma:        "134a0aedfea4cc9966d914bd14b17d97abe7fdd4bd7793368f3a2a5f1760ca87"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7aa6c1c1af336577fe46b3670068ed42beb9c991f744ed7b42e6905e65d6f031"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eff1c18cad71161b387dca7772694cbd309f849d3562e61002996a96b6c2f4b1"
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
