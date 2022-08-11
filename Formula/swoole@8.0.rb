# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.0.tar.gz"
  sha256 "460ae95865af17bdd986720c775b3752cedfc27c2b0efe96cc28ff24d5b1ffdc"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "959fbdf52a17fc53f5279bc3bef9b72cd7a5b58312708221c35f8db79bc64b29"
    sha256 cellar: :any,                 arm64_big_sur:  "077ca7c05b6221e2280d8674cdd75a06380448ac9695cb0c02162fb9c22a0c82"
    sha256 cellar: :any,                 monterey:       "d63237dddd0ed224e2b94716564f30d0d676d60a8d2e5b27b316ea3c4ff7272b"
    sha256 cellar: :any,                 big_sur:        "79db847fff62d70e96bcf2ff3d4e5678ac20bf0bab5fc1b61819e6eeab22f5d5"
    sha256 cellar: :any,                 catalina:       "4c260c4f4a5ec911ee7701df6976bb80022427240870112a17d7f7880ef8a344"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7fbdabc3e4ea277cb9d6b3392f889d2a0f53127c93eeddd2c72b65f4b58b1b34"
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
