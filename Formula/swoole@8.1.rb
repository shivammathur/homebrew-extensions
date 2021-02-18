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
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "53bbfa21d9ef8ffa05e86c2ca11d413f459fc014134d3409a3842cc4b38de589"
    sha256 cellar: :any, big_sur:       "fdf5b5d4b6151857eee480208b57c190a82ca11ae54d724f010c849e9534a62c"
    sha256 cellar: :any, catalina:      "357c87ddcc7a88dbaa18372744131d5abf15bbe78a7641452a937bf566819c12"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
