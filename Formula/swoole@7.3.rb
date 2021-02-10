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
    cellar :any
    sha256 "be0a81890bbbc747706b1131f6eb2d99423c13d38b58b4373606226a27c09584" => :big_sur
    sha256 "58947a1302df48dc16649bd027baae85fc646595902a95cf248acceab59f2182" => :arm64_big_sur
    sha256 "f3f0c89c727a0ac6e18533cf485bba8af6ae0e4c2c360a6eb3a60151cc76c404" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
