# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT70 < AbstractPhp70Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.3.5.tar.gz"
  sha256 "fad1f7129e54ffae8fce34c75912953f3afdea40945e2b4bf925be163faf7cfc"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any, big_sur:  "855cfacc8597078e07e58197916d3e444fbdfe851d018c85795a058b66320e60"
    sha256 cellar: :any, catalina: "4e0abf4220c24c5fb62fea6178a5a199709ed0d3b3509acb82d648c3763a6bcb"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
