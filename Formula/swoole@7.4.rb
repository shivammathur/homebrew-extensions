# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhp74Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.4.tar.gz"
  sha256 "fca3337a269db0533c0c7db10b48aeb9e6e5d7b84188d17ac59576b3f365fba3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "236eafc37a00fe97e2b31b934afc365a446ecde6b1d2f4fb36fb4024e65d5e8e"
    sha256 cellar: :any, big_sur:       "b495ce7e4d07da6f242a47f1f29f490853498e88a7caffd7da2b85af16002338"
    sha256 cellar: :any, catalina:      "2575b91fd4c52d19e86ee4bd04f4a7655dae5989c121fc3d1865a23080414b00"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
