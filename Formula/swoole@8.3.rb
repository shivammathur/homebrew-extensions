# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.2.tar.gz"
  sha256 "056703031d052049fac86434b58db0fae3a75804d872871d01ba2e9b82685d31"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "4c2386c5bbabe519396a54cdf7ebf7919c15486907924a41862e153f523aedb5"
    sha256 cellar: :any, arm64_sequoia: "47d42904e11e5633644b443b89398f4ffc8f5695f34087e28d0b0d5561c94401"
    sha256 cellar: :any, arm64_sonoma:  "5a78daad241c7af0d2ca72730ba344aaa95a3efaba9d9308012aa1a73f2536c4"
    sha256 cellar: :any, sonoma:        "fa6d24b5183e4aefabab1ff1a6eb6b59f1f157e3abf5184305d7ef0315084431"
    sha256 cellar: :any, arm64_linux:   "161094e69080e71625c4f74acb9243ea3b68c4d210bc90bd517bb7d152c28435"
    sha256 cellar: :any, x86_64_linux:  "b01dac1b59eea5ad7d1ff96f343b164e6e1341f973d120033ec391dc62d1c16b"
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
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
