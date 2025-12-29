# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "34d1769075967b43fc056c68a26feec65a45c7787292c13f26014ff6c5576a30"
    sha256 cellar: :any,                 arm64_sequoia: "361b2ef16915ec955959c882084cb9b6c82d53f733f86ef5137fa47999a16145"
    sha256 cellar: :any,                 arm64_sonoma:  "5fd5fd73f678744592b2b6dbda5496a7a60bd65f919a37316baf57e1e11c73c7"
    sha256 cellar: :any,                 sonoma:        "7dfc429e257436abefaeba4fc7355ae9669c3fb347ef52d619dc80dec9f55bb7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "892484531701c407f88523702e1cba9166846d186f2418fc8dedcc6e9be0cb68"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d3e35d22c09a38858e4c29430661506d2508448791e194cad74798fa5d17c18c"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "openssl@3"

  uses_from_macos "zlib"

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
