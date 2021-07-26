# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.0.tar.gz"
  sha256 "a1d052079c370405f19bafb346e976a8b0e9a0a90c859af9cf752d4ef1025981"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "7267a4ed342f81f77395aaeff453a988524a41b2c295545c8b86a73e05a746dd"
    sha256 cellar: :any,                 big_sur:       "7a3b690c847b1d5b255254882a15e87db13ca5e9c7a7bbc35fd2bbb51e2cdc97"
    sha256 cellar: :any,                 catalina:      "55707420631fa7f0129fc2f6a963302954a90a423dd7f90fefe2d4a06af091b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dd3a93e5c9008b7cf5d707e994d582cf7f06797937efcb72fc570afe50f717bb"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
