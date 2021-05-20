# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.7.tar.gz"
  sha256 "f64bf733e03c2803ac4f08ff292963a2ec1b91b6ab029a24c1f9894b6c8aa28e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "32e6d06b54c16d871f16d770be706754e4a86a976499cb763d4d87dbaa0f0992"
    sha256 cellar: :any, big_sur:       "b1f55b4b1196f540394d3c94609e72d09ec210ca9b82d76bb649c3ec7cdfa4c2"
    sha256 cellar: :any, catalina:      "0a8bde6f6e8fd22d8714cb3b5cc28626b77bad396998c4fc674666b4be25db2a"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
