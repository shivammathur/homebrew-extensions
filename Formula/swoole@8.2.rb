# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "549fe13c5a7489f9c5370a7743623411936118ecdbe77370c42335b9fb62f5af"
    sha256 cellar: :any,                 arm64_sequoia: "40b877549639d4d505712238eebde181f81520b5dcee5c383073e2b5b8557217"
    sha256 cellar: :any,                 arm64_sonoma:  "1e477aa1e824ff7cc08eea1052828b351b42b142160c7a4ab6595c10e5150f29"
    sha256 cellar: :any,                 sonoma:        "807d9f46047cd4f4d27d6464a079258bf29fc7248a3eac1890363c2a263605ae"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eaefdf36678d8ef50b267dd06b772523c1e792a38a4c48d50f1cbb37d22e539c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aec4ed0261b291d323e72a1045bfc1f4f8936bb6c6b48009cd61cd24e38c41d4"
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
