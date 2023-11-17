# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "f7786c3463b423e578e43cbee0e81565ca68e6df8ef3816c99595414dd30e28b"
    sha256 cellar: :any,                 arm64_monterey: "fd0902e626494652200151dffdc22dc99a3d64fd2b3d7531c2a56d268c77be6b"
    sha256 cellar: :any,                 arm64_big_sur:  "e471895bb4f9fb19ce8121cc4107052fe10b1440018063ef5e4b45bbeec2d972"
    sha256 cellar: :any,                 ventura:        "a61d8ed41449ac7d704ed81ed9f01f1bebda77f217bf452f6dc047627a6730b7"
    sha256 cellar: :any,                 monterey:       "f72055ca733cbdd344294e320bcf0b218cf1daddb213c7fddf3f99a31608bbad"
    sha256 cellar: :any,                 big_sur:        "faf88cabf890c66db1b515bd730c44170383d3cba76840077fc02662e0ebb891"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b49b5ecd8faa545d74f4be8a3d892089ef2b80dd68cd97d71ce4d9b345b42e8"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
