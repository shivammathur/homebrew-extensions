# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "ac2f7b9e488ce488e7b8e04ed6df8ec66cbc1e75a654979c8aad46583a76ab9f"
    sha256 cellar: :any,                 arm64_sequoia: "3c190a235ec3f7e7df2677c4dfd619e76ba854bbc81d39c4d84c6a900ebf2ed0"
    sha256 cellar: :any,                 arm64_sonoma:  "023f6fac9a9b9709504375515766dd115f87d4462987a3157610df38b6419695"
    sha256 cellar: :any,                 sonoma:        "91f9771b89f3ae1299c67008c036094cdcf96f6d32b3d32e244a9bee840192e7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5e82f76dd1b36cafd1aec591614c6ece49430782be5614ee58234758c532aed7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "83f1c02757dc587e0da51b487be61f300c17bdb0fe09a3026a895fc10df8fbca"
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

  conflicts_with "swow@8.1", because: "both provide coroutine networking extensions"

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
