# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.6.tar.gz"
  sha256 "7f022cf6fa2f273915fd09f94ef019c50efa06b0be01eaadcb4b289d5622d77b"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2c57106e78c931ea43d3c5a03b4308db1a5f3fcc4dbcc288ffddf88d04464c3d"
    sha256 cellar: :any,                 arm64_sequoia: "b72379ea5a562e58acf09face99e1c8252f1f53900f429b8e9553eb79c0561f8"
    sha256 cellar: :any,                 arm64_sonoma:  "6f6504341dd3929a2443bd53d7dcb5c882e5a5b459458eb31525281d140e15d9"
    sha256 cellar: :any,                 sonoma:        "c744c3ff7096dded8df771fefceb558d3e5caf898bd6cf213cf57aa89fac61a2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5822f4f406c2da215ccf761447ff171e461689ea631908ac449d799187325fe5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "26872969d94fe54bc236fde26575786d1055338c563e5d98f1754e50b3186bcb"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "openssl@3"

  uses_from_macos "zlib"

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
