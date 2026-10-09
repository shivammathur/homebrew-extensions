# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "e1717856cfae3f5b24a90cd78c8c2e355cf298f9825785eb40f04de44f9570a0"
    sha256 cellar: :any, arm64_tahoe:       "fa64c6092dd5a0ed9d9c142606280bb0901f6dfec90f545f39db3f21db367d3d"
    sha256 cellar: :any, arm64_sequoia:     "fd6d6db9e359573df9d2e8baa8ff0b2039bb93cf9370c9352827d37ae2ee8a6d"
    sha256 cellar: :any, arm64_linux:       "3dfd402d45c3b90931502c1c8dac295a67be816304fac732676134a8e37b3ff3"
    sha256 cellar: :any, x86_64_linux:      "44f83834ba952a846e8cd8129345d1709c626f6b15d6ce947137a6c8835a7eaf"
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

  conflicts_with "swow@8.3", because: "both provide coroutine networking extensions"

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
