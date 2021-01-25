# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT71 < AbstractPhp71Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.5.10.tar.gz"
  sha256 "164d1a712a908e3186fe855afbfcbc9ff7bbb1e958552b6ad1cc36a32a72b3ab"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "84fb4776677b790a593a9e2982ad443591c38586b5b25ab8aec70a33161bdde5" => :big_sur
    sha256 "6be59933ca33aeb7986e4ee12edc3fae3a4516e53dfd633aa47d24ef16a87e01" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
