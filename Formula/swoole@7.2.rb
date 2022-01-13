# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.6.tar.gz"
  sha256 "0234d336dd19f56b7e175dddd7ce61b17b00ba24426072018d781c9815c263ac"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "2f338060faf094ae202ae95d94d845604eed12dc310b61abe04a4e1a42a1e001"
    sha256 cellar: :any,                 big_sur:       "7627374a253d1b866e8729bd0fca7f948e06d41d5bface2d33cccfdd5f1e9af4"
    sha256 cellar: :any,                 catalina:      "6345b9fe4a1949d3c1e6dcd8442d06bbdaed7e41b44af142fc8a468dd1db2be9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8eed642dbf9e3b221ee0056dd8e925b8e4fa3451b673ee4e55f51c1c910b2e80"
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
