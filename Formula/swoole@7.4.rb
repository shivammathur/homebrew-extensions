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
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "afd36665b2292c5111ed486542dac9f56a790ec9170a6805c48f72d9c77a3275"
    sha256 cellar: :any,                 arm64_sequoia: "7866958bf7c91dc7c3a4eea4b2da2341bbed1abd58005a5dc8fd0305c522ee60"
    sha256 cellar: :any,                 arm64_sonoma:  "ca7dedb3b03494949eaefe3c08fc332295a533d6262c135832ceecd782da5a8a"
    sha256 cellar: :any,                 sonoma:        "b3759254cc3d282c568e84b40929d822926ac73dba238618de5908ff4ca1a83f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "53334c63cc4eaf0a27c99cf957c6ac90b3b75938f8107d95fe645683c291becf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "65f3bed2d090a4c36aff1d589e2efc5b585c6e6cd88d5d06cf9af3b6f3a42893"
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
