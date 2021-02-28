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
    rebuild 2
    sha256 cellar: :any, arm64_big_sur: "2369f36a13f7c82df9c12c565b2bdf9555a64cc09ac93438f63fc60a43406475"
    sha256 cellar: :any, big_sur:       "5b7be52bfb50494b89466a1b2f8a2a2cfe874434aacf2e6ee0eb9aa70ee320da"
    sha256 cellar: :any, catalina:      "b509ad4098343ca7a43567a7b67157dc5c6db3249c11b3d33fdf7e4770ba8827"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
