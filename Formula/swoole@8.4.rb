# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "6a2f9cdb110800b692b7ef4567ada12105b62cfefb67c23b04047875a1d42f1b"
    sha256 cellar: :any,                 arm64_sequoia: "b747f7044296aa329f22c87f0899435fd7187de9859040905f0417d7509445f5"
    sha256 cellar: :any,                 arm64_sonoma:  "326aeeab0ef8ae4638cf8310ee6ec6c887792fc50679d9147e1d4695a7593c6f"
    sha256 cellar: :any,                 sonoma:        "cfebb9de6d438b121cfe5148157f305b632f9a6652ce822db095651b4c4e0b5a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0547536d99d2771de3d616d189123520a4890d49fcd64b36e719b2884c331949"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "161bafae2ba69385d5573bec1adcca34210f34c901056023da8b2a058bd352c9"
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
