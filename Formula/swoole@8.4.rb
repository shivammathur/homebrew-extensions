# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src.git",
      branch:   "master",
      revision: "c71b7d450fcad748316f2424b8602c6f2df20516"
  version "5.1.4"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b99d45597f956417cc9944c46e494d0326e15affcc0c4781d056675e9050a38c"
    sha256 cellar: :any,                 arm64_sonoma:  "698773fe57f82baa263cfb27a16d9a3b06a027ae8e5a22df7a6c183f870d702a"
    sha256 cellar: :any,                 arm64_ventura: "dda3f6dfcfd92e08fccb99b400fee91d3dd9ca62daf1bc2db2d6b3fd929411a7"
    sha256 cellar: :any,                 ventura:       "949b2a9f44a81c856e263b35b61dfde0b239ba04882a3f3dfdb52567bb227439"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6509cccafa6caf85802c08a82099fd49886e08ab2b4bf8259b36611481301b96"
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
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
