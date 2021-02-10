# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhp73Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.3.tar.gz"
  sha256 "e93fee47c66cce13852d52e074a211d352f05f5c2644b280f653242d87c6159e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "9845b887671ea673fe3bab073f4feba7c2dcf9d5ed464a71f1f6d11a53ae762e"
    sha256 cellar: :any, big_sur:       "ca4aace84472a47486222e240ef8778b1f472ca266e2c702c3fcdec95d1991d6"
    sha256 cellar: :any, catalina:      "075bb02c1689304b7807648ead4624758cb1af3fd88a8be47c161cfdb247f67a"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
