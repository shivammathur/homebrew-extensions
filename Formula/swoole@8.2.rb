# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.0.tar.gz"
  sha256 "ab8b1a7145530bc2e8d9c44d6573f5b1ef81e99ebe17ce38b6992188e1d701f3"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a7c76c06cc1590ee57690d8480bb446c047da40669dc5cdf1ec8bf9148f51986"
    sha256 cellar: :any,                 arm64_sequoia: "cce5a9c3d004d39e2b6e1402b1cdb8c3aee553debdeab06439e7579db0dbab9e"
    sha256 cellar: :any,                 arm64_sonoma:  "7d00a3c8733769effb10805415a2eb10972c43fb40d3e2995eb65cbd86bca737"
    sha256 cellar: :any,                 sonoma:        "949236c3a2b3df05f7b47f3cdb469c810783608f0baae723a4b4c8bae9fa872d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4169b79bc788dc494573d76714b76124307c62b83290e496e04fb9be864c8fdc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "17d1ea36c09f4d841c17b3324d1e4d3ef248f7f50f5c5ddc1efd559582ca8358"
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

  conflicts_with "swow@8.2", because: "both provide coroutine networking extensions"

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
