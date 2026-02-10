# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.6.tar.gz"
  sha256 "7f022cf6fa2f273915fd09f94ef019c50efa06b0be01eaadcb4b289d5622d77b"
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "88fc4e9976b53cd26666cc6e23bcecfcf218408c2f3f81403ae17578ba7bd9ba"
    sha256 cellar: :any,                 arm64_sequoia: "475e3da332a38d506766c280d024125c3a1da6b779ffb4c4e577aa7263153256"
    sha256 cellar: :any,                 arm64_sonoma:  "bd43050ac6c199f7576cb1ae58c03d3cde63eadee52eb53a51ed367a70c4619e"
    sha256 cellar: :any,                 sonoma:        "071dda75d1c8acdcaa6e3c2e1a5143e47e58d7ac1614950e1be915a63ab278c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3f2fc1f1fad0fdf37944f3b1ce45da486915cd162c032aa9fed8da35ba51288a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "54586075594c18932d5022f50ea7992e7dfebb6eca50f5a206f59179e8910085"
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
