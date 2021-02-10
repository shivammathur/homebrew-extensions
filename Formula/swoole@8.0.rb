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
    sha256 cellar: :any, arm64_big_sur: "b10ad1b330ed4e4869bbecce97d5b92eb8857982499b35a3536216338b83c7ee"
    sha256 cellar: :any, big_sur:       "72a5e1fc18cfa3ba21192bc09a6d8e1346c863b1058cda864b15171e1b2769f5"
    sha256 cellar: :any, catalina:      "abea85b4325506632256b41296ab049daf8b70bdfa94250a7f4b26585941d3cb"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
