# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.6.tar.gz"
  sha256 "7f022cf6fa2f273915fd09f94ef019c50efa06b0be01eaadcb4b289d5622d77b"
  version "6.1.6"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "35bacc8e84153d49fda2fc8d8b0ba434909c11987f5620b77b7bc045c5f41b6d"
    sha256 cellar: :any,                 arm64_sequoia: "7a9d8e046e7efb44a0900b596ee18be6edebeb93474cbfbe530230391abeeab2"
    sha256 cellar: :any,                 arm64_sonoma:  "8a8bf8683f13e46b87c217ec1289f88f79375243408003d9d39cbc5b7f31a2ae"
    sha256 cellar: :any,                 sonoma:        "cda2226243fc910f79e45b844825bdd4dc19b5f9756758571c72853ba1e9c681"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cbcbaa310381cd2a8ab0d1ad0c765ec15f5fbe242a556e60824b465ea961e647"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "881e231e5eaeaf903ec50fdcd940a4ade112d7715d550c8c0bce64d97590533f"
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
