# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.2.0-rc1.tar.gz"
  sha256 "a38edfa6a8f07c472ba1533756cd5b42f177572359e8841081c5335b7998641c"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_tahoe:   "d6b5760c7ec4d4d51273b36800810be18e60a01f71d7900bd5ccd89db897939c"
    sha256 cellar: :any,                 arm64_sequoia: "6f0801cca1c5b9d9edce924557c6a8334ae1c88a896e3ec1f83c44bf0817ab16"
    sha256 cellar: :any,                 arm64_sonoma:  "05b31b725d4628ae8aa2df58dc31339087ce1eb965a978ccdfbe31441ee607d3"
    sha256 cellar: :any,                 sonoma:        "8018d234cf610d455e4b045e55790ccd7a04c8f3e7e1a9ea9c7f82e0c694928c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e82d3dc00ef457ed811367c4c3a072125788fc00533a3435d1d3e809429208b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66903bd4488d681a591b471a8780f65ab777621c18ad2dec3fc67f08b33fefa9"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "zstd"

  on_linux do
    depends_on "liburing"
    depends_on "zlib-ng-compat"
  end

  conflicts_with "swow@8.5", because: "both provide coroutine networking extensions"

  def install
    args = %W[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-sockets
      --enable-swoole
      --enable-swoole-curl
      --enable-swoole-pgsql
      --enable-swoole-odbc=unixodbc
      --enable-swoole-sqlite
      --enable-zstd
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    on_linux do
      args << "--enable-iouring"
      args << "--enable-uring-socket"
      args << "--with-liburing-dir=#{Formula["liburing"].opt_prefix}"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
