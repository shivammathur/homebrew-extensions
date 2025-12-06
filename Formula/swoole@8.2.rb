# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.4.tar.gz"
  sha256 "96e7e5c72062c797c25d547418c7bf4795515302845682b7a8aa61596e797494"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d99e4c535f22c3d05b63aac36236fa0f8f00423588fccb89353ce896b3e70f9f"
    sha256 cellar: :any,                 arm64_sequoia: "77cc36e4e072b51542ae7b39b2967d2c907cca3d6a2c8b7a8337ef6946241dd4"
    sha256 cellar: :any,                 arm64_sonoma:  "93aaeec54ffc3677619955ac7073b8e2129a4a75e994b76f09986e713718d7c9"
    sha256 cellar: :any,                 sonoma:        "b11598e25709a51da5d473b535692dbbc162854bad60bd11c958b9f49db3a8c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a18aeb61d275a6ac368334b330343973a2939a3cb765afe1f0411439d01a1649"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "437877c0d4c42d24a2ffe36dff1269cd322cb4443de60b4ec3cc45df0a359135"
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
