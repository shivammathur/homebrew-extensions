# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  revision 1
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "e697ab0a5eef4b995d28d1b4fab14cc1f83fcacd4fcafa13953732560b783c87"
    sha256 cellar: :any,                 arm64_monterey: "f45dc24f73bd4d67037402081e33c736ca6b762ae99fd735edd4f5408b1c35e4"
    sha256 cellar: :any,                 arm64_big_sur:  "3e23de61d4c807bea2fc8ef2e60a12a01897f67a3bef776de4b0d013a9891746"
    sha256 cellar: :any,                 ventura:        "1624a886733b441db43be05aa94ffb5147ce7e0b7d636b23d264a3e053cfb112"
    sha256 cellar: :any,                 monterey:       "0395c479c265e24263d46bcda46b501f5b1e3e73e55a033a4df5ff7527bfb95b"
    sha256 cellar: :any,                 big_sur:        "fe18ac11c1227454d55157c384b9ec628132befe702239ea15a2d17dbe720226"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a283e29058c5a9f30c9ab14a7886fd4db48b1f380953b45f67abc304697479a6"
  end

  depends_on "brotli"
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
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
