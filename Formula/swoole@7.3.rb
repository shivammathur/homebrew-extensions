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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "7c5347791f637de1cc239cbfe0169d70dfbbc8bce2bb81b56c96cb390ccc7ffd"
    sha256 cellar: :any,                 arm64_sonoma:   "cd4952ea2406a6aa990d1029dded4e1d987185b23eb4c159a5f029312104e36a"
    sha256 cellar: :any,                 arm64_ventura:  "a8c671f8794c3221c9c81b0b56573d166db38cee15cb0c3240f8c32b4176ff16"
    sha256 cellar: :any,                 arm64_monterey: "453cf4f29f014597ea735f77304f7a3d630bf52704422b6c118c529b896034fe"
    sha256 cellar: :any,                 ventura:        "ebf90cee20c92e4aec3fb8a99642569b720de5cb00494c0c8774c50a898de9ec"
    sha256 cellar: :any,                 monterey:       "feb5e7d208e8d30b2e9acc7ff7b1681463aecea87c9dcabd060f9caae8c3a9ea"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "5c39a2cf7fe7fae3ef870b39552c717f13b57ab5d088cbdc3903679bdd4d202d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7640a29019ce9242104cdb1b761551b5b4a66f1c7b14c5934762f3f57ca390de"
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
