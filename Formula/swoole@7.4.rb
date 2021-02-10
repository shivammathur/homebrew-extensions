# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhp74Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.3.tar.gz"
  sha256 "e93fee47c66cce13852d52e074a211d352f05f5c2644b280f653242d87c6159e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "f32ce44d8bd97f7722de1eea0eb1416da149dc3edab9bb26c4e08376652c2c23" => :big_sur
    sha256 "4745d79d4d2026afc7b852fc6cd5fc5c0a49ae4b449714ee091958d28f5f024f" => :arm64_big_sur
    sha256 "7b9aa5446b869ec4e4ee4fc52b365d8a087c0b26adcf7d3190d6b34ebe0f4d6c" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
