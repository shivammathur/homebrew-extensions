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
    sha256 cellar: :any,                 arm64_big_sur: "4df33c369c08133b231a024ccbed26ee196253b356c5e992185ec8db4e3e22fd"
    sha256 cellar: :any,                 big_sur:       "33a15892823ac551db7058831725121ee6a412ab715cbcd5e4fd37be561a10fb"
    sha256 cellar: :any,                 catalina:      "789fcafea4f3c8730cfc6f92082e86fe0cf3b4a4fcbed536eb04a1ad7c136308"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9d872e857f970d9ba5d2cf315e5b2615c19cc6ad60534d9e8fb4c93d3c6865b"
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
