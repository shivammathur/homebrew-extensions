# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "f3b640023da0324d78b3bf7b75ce2c875d0ea328d232373f7fcc6a6be4b3c3f2"
    sha256 cellar: :any,                 arm64_sequoia: "2ba3231e92190c64652a5efdab07de8e6c8ebfc9d9f0679caab802cf8815f88c"
    sha256 cellar: :any,                 arm64_sonoma:  "571713019a95c8ac153e53f119e68c11fede9a75715a5c00f3d1e96b834aa9cb"
    sha256 cellar: :any,                 sonoma:        "62ca8acad88086a32d03caae289c1e2d474e883d2b52cb89ee45683f2bad4147"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c1ff06db3c52ba44020f9d2a154d7653917247a1a4cc7e73f34b086f434f262d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f675397e122af7409272aa435c57c65db7f6e78abff054c0c79120692afe6c25"
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

  conflicts_with "swow@8.4", because: "both provide coroutine networking extensions"

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
