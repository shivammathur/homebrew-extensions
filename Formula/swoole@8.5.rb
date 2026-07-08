# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "f52e9918f3a16b33cef62d9302f554f89b2f9b86a70a0f4da9bf6c6eb94c1458"
    sha256 cellar: :any, arm64_sequoia: "0ca58652ab55327724b385574197a23a683d94236af9e2863e7d5ab42d92e0fd"
    sha256 cellar: :any, arm64_sonoma:  "3ce3bf7a759ed35be411c019b25c8864db8c4a749f4f30602fe4d2e48432508c"
    sha256 cellar: :any, sonoma:        "516d4f18c4b0ece19d781b19d8956722cc8fc1b102a0bdc4a684fa31ae596432"
    sha256 cellar: :any, arm64_linux:   "a8823aa2e58841ea0eabbdcd907247cba54a1f5f3196db7144316c9fdbad64f9"
    sha256 cellar: :any, x86_64_linux:  "9e058cd8f99d8a78829f371c58416962f278366da6ad6b48a34b7b05c8dd6b83"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  on_linux do
    depends_on "liburing"
    depends_on "zlib-ng-compat"
  end

  conflicts_with "swow@8.5", because: "both provide coroutine networking extensions"

  def install
    args = %W[
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
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
    ]
    on_linux do
      args << "--enable-iouring"
      args << "--enable-uring-socket"
      args << "--with-liburing-dir=#{Utils::Path.formula_opt_prefix("liburing")}"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
