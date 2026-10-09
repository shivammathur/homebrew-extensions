# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.3.tar.gz"
  sha256 "dde8d2a4a6b5c5cd418aedd8561760baad59767a2f8a963b2c0e9eb9c86f4c8d"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "37276d8f8578093312cb6d45866b810e9819b67a487ba363437b359a72295713"
    sha256 cellar: :any, arm64_tahoe:       "a264b81fca5d34ddec1aacd5070aa3d7a55cbf1afabddd9c13402fba2d15583e"
    sha256 cellar: :any, arm64_sequoia:     "3cb6e5b42089abe8ca447daba280a2c1b64e51ed39ce468a8493bbcbde9ec7d9"
    sha256 cellar: :any, arm64_linux:       "0e8f64288fd520b72fade481dbc88c77db895740e0f9f7b0345b8da563e176c6"
    sha256 cellar: :any, x86_64_linux:      "554a067590e52de7f48b746fe601a58697b16ac4c8369f90cb1b9aaa009153e7"
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

  conflicts_with "swow@8.4", because: "both provide coroutine networking extensions"

  def install
    inreplace "src/core/misc.cc", "sw_usleep(1000);", "usleep(1000);" if OS.mac?
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
