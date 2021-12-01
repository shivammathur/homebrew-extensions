# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "87df414aca0669dae6ab683e2c371d3c045bf314b94b7c0d02207dd1168478af"
    sha256 cellar: :any,                 big_sur:       "05091d2f704be96880f654b1f1ca1bb6083a06c76f47110682e1a7c7d371fa63"
    sha256 cellar: :any,                 catalina:      "619356b2ba28b896602130d951b83b5bd77781e1e66f20b5fef24e4f353025ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3a8e5c8c14cd5d84f1c6e8ad9c7e1b50b78c7003b9362f36a2c2574e9e992125"
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
