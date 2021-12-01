# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "a40865c61bce5aa6ebb83d78e1d89c48e54678b5671ad2cfdfc9a87aeefefb2a"
    sha256 cellar: :any,                 big_sur:       "d862def577d5c69863fa3da0fcb3a0c4e1ac41bf120c3b225db9e9d573e4116f"
    sha256 cellar: :any,                 catalina:      "c291ae9251c2dde29f4da59a2269c7dfa3da09dce95b166511112129d70547f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f2ec17afcbbb9216d37cb9e02ee3ec15964fc10f6cb688c1220d85ae9476b98"
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
