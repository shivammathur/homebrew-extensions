# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "9eefa791c9045d78efd36dbff7102a3a5a0ecead7ac10ee59195de57c64350dd"
    sha256 cellar: :any,                 arm64_sequoia: "fb4a7a5c51a76e161cd30e155c707f32a957d4dd6241f520ea4125de89079bd4"
    sha256 cellar: :any,                 arm64_sonoma:  "2ecc35dfa070bf5b7a8b2d906485ffa153af57181d68c5f84f792a6431464871"
    sha256 cellar: :any,                 sonoma:        "284e9fcd3aa777f5fea645a014936087eaddc80b0372c1200b6632f80a720964"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7e65e710169bbb8b09336b39f1f8fc1a1633195b1a360d34e3b84da84f14639c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58c1049bc19d7bc6670018246d4e6eaa58f1c55056c2887cf1f89e84c7547dd6"
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
