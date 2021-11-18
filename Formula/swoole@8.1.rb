# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.2.tar.gz"
  sha256 "2b817f04236363cec6fb79e62df7838f2d885dadd569bdfb88d62d3792ddcca0"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "da40d4ca580ce0c362fe0a8230c6f9991efa825176ddc3e093085f78b8e1b8a9"
    sha256 cellar: :any,                 big_sur:       "aae2290ccee13f4322840a0442e3d93b8608ab4f0652931c04654ae4895ba814"
    sha256 cellar: :any,                 catalina:      "73d35361d8b016f772adc72c4cb2a0fa90f16ee16af4167dcf0e45c51e6d3fa0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ffbb94970ca0c896f88553d9e21f731959f15c4540c7d31fcdd9f6ef2904f228"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
