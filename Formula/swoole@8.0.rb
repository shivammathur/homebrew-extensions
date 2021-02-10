# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhp80Extension
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
    sha256 "400c7f25591c2f61a7eeb90bec136a358b51a7040cd98f5af3279ab1283ab81c" => :big_sur
    sha256 "f12e6d2d6d60917297aa9b8eb880fdb80f8d1c861cf787b18c1595fed01356b2" => :arm64_big_sur
    sha256 "db9f2c36b4aa61463531740a9048a8db362b771cfed464361f055d56cbf2d8f7" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
