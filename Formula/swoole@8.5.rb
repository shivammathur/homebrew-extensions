# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.6.tar.gz"
  sha256 "b0a97398d50dc9442d48a71238cafa5f75d2c53d2e35d12a59235f9d52dab718"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "6c152e88f98180b0d34fe8b154fbe1ded8d4ec91bba0a3d958a6a20b9a0e3796"
    sha256 cellar: :any, arm64_tahoe:       "a2292ba00008f98a6628ffafe83255ba0f9e778f4953e8bcdf702d501515fa86"
    sha256 cellar: :any, arm64_sequoia:     "3b43345e8354c9e76ad6c75af387af2f8785a2a2d7edf1da7afb579490e75f30"
    sha256 cellar: :any, arm64_linux:       "caace716242d19cb1e19f12106868385d7d743fe2e0d8dd4926ab384d179c565"
    sha256 cellar: :any, x86_64_linux:      "c5419fde7df8bd7c21dc3c58e2e81493feba5d1476801b836fa204de272c6bb6"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@4"
  depends_on "zstd"

  on_linux do
    depends_on "liburing"
    depends_on "zlib-ng-compat"
  end

  conflicts_with "swow@8.5", because: "both provide coroutine networking extensions"

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
