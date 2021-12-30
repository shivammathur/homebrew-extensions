# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.5.tar.gz"
  sha256 "369f1ee8705eb38cf20030a65d7017056e51a0f24fe06397740a76eed8f6a707"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "4f4d90b778e4bb74bbfb10620077403cb34f4031ff1d558b447645f6743d6486"
    sha256 cellar: :any,                 big_sur:       "28ddadbd24686b40744cc60487ab3449c9eb99f208a87d071366dbf91c4e3ce9"
    sha256 cellar: :any,                 catalina:      "808e4d913e757b034312673645ef6767e55550d87ecdf2cd6afbedd08a782fa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4959c99fedf2e7489e793da2191bbc32832f3d47b974a329413f177a090c572f"
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
