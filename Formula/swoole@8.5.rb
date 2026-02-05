# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/2fd8ea4c07899ef8bac028c9d7b18fb1cd0092d2.tar.gz"
  sha256 "bd3eb3486fae5484e59f61e96f1448b90ec47527befc7d558baad50e285576d6"
  version "6.1.6"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "afef5b391be7230bf546b3b5bd87ff7ee9129b9c700e51aaac2f5a2c978749f5"
    sha256 cellar: :any,                 arm64_sequoia: "2848965226315370226bbc3e610d892f0e8ad643ce0a7b73ebacfb58f329cd96"
    sha256 cellar: :any,                 arm64_sonoma:  "981458fa13f022539c5d6e355f71bd5996f4742bcd3fa9f516b3327bf6ce07a0"
    sha256 cellar: :any,                 sonoma:        "11a25cc0e73f755684a1289df49ccf471e8f6a3ce02d53a89f0bd5acb65eca7f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a2789766f2af1cbe73b23f2cdc100681cfdf8f4b46b1e21f08a2e94a3eb1008d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ce8db3247102ce5016bc578e0afd56b71b40a9566547c1f24ed8425b068240f2"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "libssh2"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  on_linux do
    depends_on "liburing"
  end

  uses_from_macos "zlib"

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
      --enable-swoole-ftp
      --enable-swoole-pgsql
      --enable-swoole-odbc=unixodbc
      --enable-swoole-sqlite
      --enable-zstd
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-swoole-ssh2=#{Formula["libssh2"].opt_prefix}
    ]
    on_linux do
      args << "--enable-iouring"
      args << "--enable-uring-socket"
      args << "--with-liburing-dir=#{Formula["liburing"].opt_prefix}"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
