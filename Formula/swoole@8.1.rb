# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhp81Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.3.tar.gz"
  sha256 "e93fee47c66cce13852d52e074a211d352f05f5c2644b280f653242d87c6159e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "d4351a831d2ad4dbf61530c8294c62d10ae44058ca174af21db0206668ad62d1"
    sha256 cellar: :any, big_sur:       "d157eafd10ccf7278c49adb48baee01414b512030c0fa1e5165b04f7578ff331"
    sha256 cellar: :any, catalina:      "80fb397b328071429c8dc9f56cf088562741139d151bcda1f7478784a16d52f3"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
