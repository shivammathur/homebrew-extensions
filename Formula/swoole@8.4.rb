# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.7.tar.gz"
  sha256 "46c8d9bcd1c972fe71a7aead3e43e1bcecde2d8390b393413d139f0a7486b8e9"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f80af5732f2f3d9da95d61d87ca68249960a0569666b2775072792f08c04175c"
    sha256 cellar: :any,                 arm64_sequoia: "45af4b0492b162871d924a8746894323113e6ed8f637bcb2e05c23a0b7707027"
    sha256 cellar: :any,                 arm64_sonoma:  "a82eb38411b98e62c60a2f1b10fc344d79e4dcbdb9cfd422ab536a343e313c3d"
    sha256 cellar: :any,                 sonoma:        "498ab27f5b727b6c64486834cd93e7bf7c75c4305bedf81641c882dd54a9e4ce"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d49a2e8d9f65e74c83614d574fc1e700a4839f56288419e0e993b51c21a90312"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f16802cabdc7c5b48208e65c85c50d44c2d389912c4248047407764411ea0a4c"
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
