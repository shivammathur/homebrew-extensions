# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/794f30965a130a2a1ae94a2b42750306a2035b1c.tar.gz"
  sha256 "d48e6e3514c137c2e8ea68ab2f4fe14b7aa21191ab989f159af9d82e1af59f66"
  version "6.1.6"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "747c568422cf9bdf14e31313180aa7b54393e1f5bcbe1518b1baec215a9b16c8"
    sha256 cellar: :any,                 arm64_sequoia: "fbc5491a289218c42286369ff71cdce03479110e7b7077feac05e4b1d8bfe5fa"
    sha256 cellar: :any,                 arm64_sonoma:  "efd0e20cf71470490abc2f0636d08e3757ee942770528b3ff11187ba446cf136"
    sha256 cellar: :any,                 sonoma:        "d9f82f9d9c93ccad127dde5c5ef1114d175ed3c39c426e21c43ea5190d73a011"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "698812c15db6de933bee69b29359ad4f679cc52c20a661587d13a53eb3aee559"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11168bb68f465b33fbaed1b0aefbfa7bed7966e61254e2c5c4866d098cd48860"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  uses_from_macos "zlib"

  conflicts_with "swow@8.5", because: "both provide coroutine networking extensions"

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
