# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhp81Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.2.tar.gz"
  sha256 "ba0f95b85da77096c535e4919935bdcd07742641e9664b715041343c902807c5"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "96908fa8762381216aa6ef1492345378f9d0ea3cd858cd1a045fd31a12d4234e" => :big_sur
    sha256 "85242ffab1bdb32e21cd83ee9695d6e29b36d235b26ce2dca5a3b51dfee010a0" => :arm64_big_sur
    sha256 "dee53e396bc82e4f56da5d2205004d1fa6fe85b733c140b80de862692a460aaf" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
