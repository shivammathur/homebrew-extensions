# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.1.tar.gz"
  sha256 "0fc700c8ea65ecf5247c7394a49b1f211e4a419987dd50adc0b0eda4ae1523c5"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "f7d8bf4aa558949861384feccd604e7dff7cfc3f424ce32796a7179d872d1a97"
    sha256 cellar: :any,                 big_sur:       "1cf6f53794b46a0d0c41d17933f8f4d20b7d6ace312d1d63d5cd0b8821e334ef"
    sha256 cellar: :any,                 catalina:      "97af7f3fe9cd19409de2af5c60f652f6a2c853f9aa5441a134635886007fcb37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c8471a54a6d556b433c403a5e5f18386f65da5cf72b1df6f41e40394b0ec62c"
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
