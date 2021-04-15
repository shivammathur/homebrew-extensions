# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.5.tar.gz"
  sha256 "c93f6a0623b90ca6a6c96f481e6a817f2930b4a582ca0388575b51aa4fb91d38"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "a39b06fa997f4c6552af2ff148a43d0210dc344d67201d1121559df08798a650"
    sha256 cellar: :any, big_sur:       "ae4133106cd0a5bf4c2d3ff038b4aa93b00d6e2f4e77ab4f0129d192d2f9a383"
    sha256 cellar: :any, catalina:      "c5d4a68974cb20b6ccea702a0fe0e21958819399b7754fa8a6554123227237ac"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
