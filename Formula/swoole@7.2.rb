# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.9.tar.gz"
  sha256 "d859bd338959d4b0f56f1c5b3346b3dd96ff777df6a27c362b9da8a111b1f54d"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5c3df6d6fdf7b9b207ad57ff42ff8bb83cfc1d9fdc3306adeb926eca524935ca"
    sha256 cellar: :any,                 arm64_big_sur:  "b2dbedc5a2fede05dfb2e6560125e610e352774094181045c97e0fa6243b92b0"
    sha256 cellar: :any,                 monterey:       "0882e84d723bcf4cdff2d3c9cc950209b70d1ed2ea357a87980a65649102b7e7"
    sha256 cellar: :any,                 big_sur:        "ef945d3fc695d35daa1e4a13847e36b3c221594f6d05f74ff135dc076087d14b"
    sha256 cellar: :any,                 catalina:       "33199e66e921def373cf3a15f89df99263338ad4e0bee9c5b8a9a9578c90c7bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "be5558e72a32b5b2315c2b1b5aa1c2147db66f92b3d5ed403dfeb54e551a505a"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
