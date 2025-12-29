# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "6951fa0179c46b74a4f4a5ae29d8e31bdaa6e386c85058a9b87d61e14107f613"
    sha256 cellar: :any,                 arm64_sequoia: "ad8a5bef000c12566f4be39f390ebe75c94b818f00c797b83fea273206815a32"
    sha256 cellar: :any,                 arm64_sonoma:  "3de0eca1985f0ff6f2ee15bd15361a620ed532c61b1e8e75b6d86cd4ee2a7d09"
    sha256 cellar: :any,                 sonoma:        "78315d23bdd4f1a890445346e9451ff827d3b4a4fb8446f2c1461ea8d02f57f9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f81a30de4868253c45a18e8a13592951bd18b9e1d9358948a40ec2d0e158695e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a23949f09de7b02e00623c0d91e7a65f375a758d05ea3941faf6ad44a55d4c82"
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
