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
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6ce7e72fb75b635eb41b0dcba0664a75dee397cbe578bb695769e8017f7806e6"
    sha256 cellar: :any,                 arm64_sequoia: "0487f5c31bf4df48f23522296e8912a9d185936c9df78d18aca6b06523880fde"
    sha256 cellar: :any,                 arm64_sonoma:  "4f7d24fffadf25160918f42e1ff66ad613b6e1ce200e478fdf081ac64b9aab7d"
    sha256 cellar: :any,                 sonoma:        "e4602b09bd53624187738feee635a2789f85f2f2604ad5c6372fe0b5d5bf4359"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "247be56de82b09e10bc778a21b1f496f02a0aedad639ca2f7f7b7faf56565d2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b13c1123f235bfde0fa685b5abd939531323880f0c99601956f89fa7f4336d84"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
