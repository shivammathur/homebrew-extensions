# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.6.tar.gz"
  sha256 "7f022cf6fa2f273915fd09f94ef019c50efa06b0be01eaadcb4b289d5622d77b"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "39ea9312bd3672da6f25639c959106d52dbdeba55b5d9cc84ce15b2db05f8fd9"
    sha256 cellar: :any,                 arm64_sequoia: "f3bcd203286123633ba32bd1ead617204f5d2772614ccaab6dd37b598551c683"
    sha256 cellar: :any,                 arm64_sonoma:  "e37ad4d75429d2fd3017b0aad66c666c6de2d5c99406f0e408557d83d7e72f88"
    sha256 cellar: :any,                 sonoma:        "e8105e1967c3030607ef9828d925ca378447d8dd4c13e71dd00255de62426af0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b4fb24740eec7243abac2cd0a58a3f8c96e63bac39aae4ced3e31f1435537a92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b6bd062c8bc111a352198b1a785ecf5c2703645f4d6c02674b3a649ea307553d"
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
