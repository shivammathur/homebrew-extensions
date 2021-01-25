# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhp80Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.1.tar.gz"
  sha256 "d4c9b1c3966faeee996344920554993885465377e40fa5ebb4e716593072eb57"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "69150a8daf7b5f31f8882d11b1663178be2bd95d859184ab0333c815553b6d3b" => :big_sur
    sha256 "faf34a59449d804a37045b4b38eb0c609f5759a2500b0353aef8a6f2949a71a5" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
