# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.6.tar.gz"
  sha256 "0234d336dd19f56b7e175dddd7ce61b17b00ba24426072018d781c9815c263ac"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "c83eae862d69b85f54c4960d4110b98b2bdee480816b58e65795d35cf408e23e"
    sha256 cellar: :any,                 big_sur:       "9f98a7472471aef60a7a932af24f1ec4d212f66a3b0e9a336d09692426f5057d"
    sha256 cellar: :any,                 catalina:      "8b59afb0f5ce06c9fc2d9dbb1bf1f73d2626c73f31809e996063c74ce0e57b71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "63c2a08444f3d0b534aa0d1d8f6e9f19a861517324ef024cf69a5f910252b780"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
