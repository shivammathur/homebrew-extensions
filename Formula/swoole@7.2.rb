# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhp72Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.3.tar.gz"
  sha256 "e93fee47c66cce13852d52e074a211d352f05f5c2644b280f653242d87c6159e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "5902800c0dd8ada128df626b61df61a135539257ee5ec2cb99e995ba39462246"
    sha256 cellar: :any, big_sur:       "59581d788c7efdf210fbb1413fa8215c71aae67c8a3766698d83e12e2e7c602c"
    sha256 cellar: :any, catalina:      "e80606b863a91177d5f51ed02ea9361f0d50b4f0c9b2383d3b4d879f913f6bee"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
