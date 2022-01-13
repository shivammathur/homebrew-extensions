# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.6.tar.gz"
  sha256 "0234d336dd19f56b7e175dddd7ce61b17b00ba24426072018d781c9815c263ac"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "534809306cdd46b57e4d333f846129cfe416787b8da4b31cf77c64a89387b665"
    sha256 cellar: :any,                 big_sur:       "cf44b1c5759cd3aea45b7e8a8f71ed69aa40122ef1c796de8301400249adc518"
    sha256 cellar: :any,                 catalina:      "928666b195fa51e1d72b5890a3609e3db23fb2658602cabeef02578c6ecaafa2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e3b2774ba7402b6cb5d29516ea9ebd5f8eb9a1c0dfaf7ca1d24769ba4dc1f43"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
