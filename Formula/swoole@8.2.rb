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
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "0fe31d60acb2d2eb164ba70b64e7be2ed3246528983ce5733256af02bc21f297"
    sha256 cellar: :any,                 arm64_sequoia: "20db793cb7638f73ce8476010516dd774c52711c7e89ad92b7bb5cc9f88dcbbc"
    sha256 cellar: :any,                 arm64_sonoma:  "2315d29b4085a97306063fe9723f198d4d8681e6d0634c7273f7ba4b0e0f2789"
    sha256 cellar: :any,                 sonoma:        "bfe6a4995a452fb88c6deef4d6d72106df8c1eccc06ca7c413f295e86f59f12c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "52dea21b148f6b0702f14da8e09f70618d0a1eb93936a03369f500a42e59ffec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0fb1b16936dc2a835c0c2cd3aab923da4420da203e9a1b70fad7ea2670d4b321"
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
