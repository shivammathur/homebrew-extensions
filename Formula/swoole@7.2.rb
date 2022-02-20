# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.7.tar.gz"
  sha256 "2083f7b5f8715ab1074b8640255f503ab91d77c6633c53421e381d8ae3bcb67e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "3d08e3e3ebdc6721c6c6a184e1a38f9a1085ffeae05f366dcb9e9657ee298f2f"
    sha256 cellar: :any,                 big_sur:       "02267370d0c69cd829bf466f7b63e787977c86033ffddad610aef8a7cbe24613"
    sha256 cellar: :any,                 catalina:      "4001e63cf3b47a3d089d38eecb3dea8f39428ee266d5635675e90fb346e9c11a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1db78c2b2a1e963ae2b1a229bb0e76a8e09887674287456497bda24f45751d6f"
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
