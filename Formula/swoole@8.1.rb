# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.5.tar.gz"
  sha256 "36e6581c11f2bf277ac192d0521c719a6f234b91e5aceffe9e9eae9f3c39ac17"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "54f3923f75e1228fc4fec2462b1fac8f9780be790b87f58a69da6ae53d457bac"
    sha256 cellar: :any,                 arm64_sequoia: "efd472bf7de4e041dc5d6b75f02062fce2958f50b69abfff1f48ba15c7201099"
    sha256 cellar: :any,                 arm64_sonoma:  "e2dd1e6eaad8d2ad8e1031b6b987f91e97cbc5a9a220d4d77ba24f8f35db1849"
    sha256 cellar: :any,                 sonoma:        "eccffc5cdc480143f62c3d0c2329d23d4acba203e582a6e1e17b33c3a3a8f5ca"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "63f17541e9de6cf5daa82afd2342a05682f965d3dad3281b5fd72abbda2b68b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7014e297edc27e214b5947cf50a7272b6a7c58a1f2f8760952d06db0ce63affa"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --enable-swoole-curl
      --enable-http2
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
