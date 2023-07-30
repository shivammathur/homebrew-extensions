# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "d6376443892cf85712bd1a8e5ba0b7172a17d854c5ea91efbd8c00b2f2b98e38"
    sha256 cellar: :any,                 arm64_big_sur:  "285341d726c47954430aceb8af07733d6e63811ae6ba0ed667d9801c2447b95e"
    sha256 cellar: :any,                 ventura:        "fe97e67eb9f987ea78510959c6215d880e34856302362739fc0053333d019e2b"
    sha256 cellar: :any,                 monterey:       "b81d1ecac107f6ba7cfb30968b7bbf535bc17ef0dc8e594d535929df8f64207b"
    sha256 cellar: :any,                 big_sur:        "82bff98a5e4988ec7148ec4694360e1c6bfdd422253a36f5daee93a5218f7ace"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c0894a804087c0454bff3ec8dd3e95d9e66eab66ffab3ddb7753867e59238d51"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
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
