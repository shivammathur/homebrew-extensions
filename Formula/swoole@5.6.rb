# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT56 < AbstractPhp56Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v2.0.10-stable.tar.gz"
  sha256 "ea1c8cfdef0e43f2b34460f88f4aaa5c1ca5408126008d332ae4316e1c9549ff"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "f28428b883330b4244a7f89185afdcd7f08b5409e95441ee8c11438c3b2ea823"
    sha256 cellar: :any, big_sur:       "d362d6909b98f39ec895c6674187f4b87b47a221655f842237b9c6d89b1b4650"
    sha256 cellar: :any, catalina:      "ccbb598f8294da5e874c080bbbfbee8c470ef3dd12c7d4c599ccc94c0290c243"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
