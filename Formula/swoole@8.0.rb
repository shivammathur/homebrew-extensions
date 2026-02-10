# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.6.tar.gz"
  sha256 "0df87a2257f800607d38b6c703789facae5e1d9a9e78cd4a52c3fdc9b6fb64eb"
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "c99310edc8f2d0b325c3cb335dc5cf5620838854a50b26a03c03f57f86a1293a"
    sha256 cellar: :any,                 arm64_sequoia: "7e2fc274117af936cd6ca880b705aa1487b75bb66b089bee823886b1694cd572"
    sha256 cellar: :any,                 arm64_sonoma:  "0e0c4220a5e18e57607eabd5d3ec2761aa77925e0105a85983e61fbb720049fe"
    sha256 cellar: :any,                 sonoma:        "c65e6443d118b23144e36dfedc58b8efd6251beb0a65ae3c8aea5874fba70977"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "65e313bf9092ad24c40b216a5218b83bb3db4f0e9b59b6345ea2f48c1e090299"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdf387f770366e39070f47eae21d52b0be6591049df1ef032b42b8e2634127a7"
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

  conflicts_with "swow@8.0", because: "both provide coroutine networking extensions"

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
