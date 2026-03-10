# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.0.tar.gz"
  sha256 "ab8b1a7145530bc2e8d9c44d6573f5b1ef81e99ebe17ce38b6992188e1d701f3"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2a636d660513e8b9b97a8cb7461bf6b3bac652a553d7500dfb5a31c0d9d0970a"
    sha256 cellar: :any,                 arm64_sequoia: "273274baa958645320cc458575ac9556e9a8b672b6fb6fd419f68390a1300941"
    sha256 cellar: :any,                 arm64_sonoma:  "a0131092a43b060d76d0a8b33dec174f9abeb2d34198fc6104a89c05a851cc8e"
    sha256 cellar: :any,                 sonoma:        "77d7f46371c3c7adeab3faa100a7d9fdcd26c80bf20fce2b8a014ee8de53cac9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2ec948ffbf0f1bba0fa4cddb611e8e1796ebd7d243dc13f779371d4e4155aaa3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5ae647e1ef3dbf842aeca1f1b53e91b415a0975681a345de7c5fe18164ccb09e"
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
