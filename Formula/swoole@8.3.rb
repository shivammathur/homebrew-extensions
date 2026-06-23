# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.1.tar.gz"
  sha256 "4b16aed387ca0eae52b59065492788fd6a748ce64467a08c6160dd524fcff626"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "8310a173b2e283209c8e9b62da722292e8a8051d9eb95478fb0cd10ac14cc90e"
    sha256 cellar: :any,                 arm64_sequoia: "58f5cde6c151c4d3e255b58b0c3daa5d5d3636dd40061ed1f8435d8a9b1ee99a"
    sha256 cellar: :any,                 arm64_sonoma:  "326baf0720a5bf096aae00aa3e84667b348e2513fc4e075eb0b2853657f3dfab"
    sha256 cellar: :any,                 sonoma:        "0120572c6b35e488660bd435492e8d0b41ca223ba9c57e89655a338836b8f21b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c3efa38a815214d2d8a15a92c597f3aea362afd5b5772f5ebb0aa2522d87bb2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9e98f9e1f916108ddc855e4b137ec0d54290368c158980494217170aad4b1672"
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

  conflicts_with "swow@8.3", because: "both provide coroutine networking extensions"

  def install
    args = %W[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
