# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.0.tar.gz"
  sha256 "a1d052079c370405f19bafb346e976a8b0e9a0a90c859af9cf752d4ef1025981"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "edd21543db4ab58491b1ba54d57040c5c7dc64e024b9e1cc831be1158b3b2440"
    sha256 cellar: :any, big_sur:       "d5c0f4fd7f3d8903c5428c4debedcf927ec7f3cbd99b3bca6b00ca6627ca4fad"
    sha256 cellar: :any, catalina:      "11339db9e1701e8603111078cb1c9c49990369efe8fe741c0eecd3e373962ed0"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
