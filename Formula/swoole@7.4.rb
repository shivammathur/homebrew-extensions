# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  revision 3
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "75d40adf1ecbb82d0bafec33bfe8cc599b87c3d6a80e6fd9130b01b84bb5f92d"
    sha256 cellar: :any, arm64_tahoe:       "fcf42f1a80274bf5ff6419cd289cf2fd9330c63024efb75a190e7d31808c6e66"
    sha256 cellar: :any, arm64_sequoia:     "0f0b85b53d84ae4a01d3b8a27d453547d5110f764ac29e545aa69271e7ef643e"
    sha256 cellar: :any, arm64_linux:       "722748c5f97bbbcfc85540088eb366934b90153a750b3fff7302ccce9e7eeb3d"
    sha256 cellar: :any, x86_64_linux:      "e17343d89db4734208c9333315ab62e019e5ef7bfe3aab58b7bf95eafa968e4b"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    args = %W[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
      --enable-sockets
      --enable-swoole
      --enable-swoole-curl
      --enable-swoole-pgsql
      --enable-swoole-odbc=unixodbc
      --enable-swoole-sqlite
      --enable-zstd
    ]
    inreplace "include/swoole_proxy.h", "#include <string>", "#include <string>\n#include <cstdint>"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
