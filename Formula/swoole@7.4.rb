# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.6.tar.gz"
  sha256 "0234d336dd19f56b7e175dddd7ce61b17b00ba24426072018d781c9815c263ac"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "a04cec4c9ca28416c9502fa02fa7fd5e61b54c5babac0b81b82ff7fa085a17be"
    sha256 cellar: :any,                 big_sur:       "bba4060c5ae6f0e8c6250bb272e32a197a488debee8ae8324724415598a25ef1"
    sha256 cellar: :any,                 catalina:      "4bbd0b5d7d8c8f3e942275789a524da4b549907f28c0af23552a36aefc3d23ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a6f52d661d277d7ec23ece674619db1750cb38a7774cf7db1ba93a3df5b71bdc"
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
