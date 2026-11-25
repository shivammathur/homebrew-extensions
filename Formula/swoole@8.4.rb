# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.3.0.tar.gz"
  sha256 "61f477f6c4515b8b85a9e353cc68298a210521d064e37e734d24a13e68c9a579"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "d13a364b39d780f30778d1ee3fc1f2dd80dde555d269eccd41f3905870436663"
    sha256 cellar: :any, arm64_golden_gate: "e29114161df356cf613c351782577001fc8c71a013ec9d9e71ba190e4ed0645f"
    sha256 cellar: :any, arm64_tahoe:       "d81ab3d6144d732d498c22b8554d04959fb0a7e6cd33da8eacd36c4b970ab6c3"
    sha256 cellar: :any, arm64_sequoia:     "1cd5c94b06874e9b750903eddd2a24bf814fdb5c77b831da9390d60e80ded1ea"
    sha256 cellar: :any, arm64_linux:       "f473d26ebdc4181f85e910be6d31edbffd6416baed5993c510af0e3164e35fc4"
    sha256 cellar: :any, x86_64_linux:      "24728b2d2d4a6a7cef7e6781ae696011f37b301fff05578ea7cf98fad8f3062a"
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
