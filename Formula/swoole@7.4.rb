# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "da3ab043f4584802db79675a2ce32bd56c706590f76be337bf6264cd69c235df"
    sha256 cellar: :any,                 big_sur:       "19bae9749e088425c29a73d9a577a9b1d3ab45a11d12051a225212051ffdc33d"
    sha256 cellar: :any,                 catalina:      "086edccba5dfcb8102b98592762dc1dd1eac529c02c07432ee18718457b9d854"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8bd3c1c4fb172f789a26f86d5e2aebe81089c60793d10ce74074e3b09058f4b"
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
