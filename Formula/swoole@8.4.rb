# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "e501fb64403307413c279c353c8d08dace672ca13222fc9cb0dc3e8a5c189974"
    sha256 cellar: :any, arm64_sequoia: "b7c33239391b09423671188762b2d47d212cc5bacc69526b9bf31167afb35e75"
    sha256 cellar: :any, arm64_sonoma:  "8818cd13c4e706689878a5b36f37e0afa122097ae3bdb181ecdd25b97a9660fb"
    sha256 cellar: :any, sonoma:        "caa723da6b44332f1b3ed7e988c020aab3250306c603ea7712777dc64e90b5ab"
    sha256 cellar: :any, arm64_linux:   "2028539f4dcf5b4986262924fa2feef7c57fb21cebc7cac73bc17f893600627b"
    sha256 cellar: :any, x86_64_linux:  "0342d0a2e3eb0bca070d55c4b3782d225f8c1ac24c2bf20d8b01214271f9b147"
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

  conflicts_with "swow@8.4", because: "both provide coroutine networking extensions"

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
