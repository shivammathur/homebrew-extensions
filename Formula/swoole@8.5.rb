# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/733f6e2aeb25c92710c2345307d3a5320fbcc5b4.tar.gz"
  sha256 "9e31d94042083d0ede9eddd6aa59655cdc3793343775562b71314af3bbcbb208"
  version "6.1.6"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "531eb59b64ff19456b6880b6752337351a542cd2a5eb373d559e0b90debcb605"
    sha256 cellar: :any,                 arm64_sequoia: "c5b8afa6345c8360572641b92a90ef6ba3ea631de5b847f114d0d7bebc2351ab"
    sha256 cellar: :any,                 arm64_sonoma:  "bfff9e34c2db0cd2e1f9af9b9ccbf912fa116fec9420ea65756a7184562c77aa"
    sha256 cellar: :any,                 sonoma:        "aab758ade76b0112db623de06a62bd1e017a9e73732cc92765a76430fc904a6e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d8af14a84844293d32e10dcfe72e378a64916c3fa531da195581b7caeebf42ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "61dfcf16c86936ab5c64455a11aac52ce846cfa910042b9a16b0511d03589cb2"
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
