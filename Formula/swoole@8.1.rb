# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhp81Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.4.tar.gz"
  sha256 "fca3337a269db0533c0c7db10b48aeb9e6e5d7b84188d17ac59576b3f365fba3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "c3e2ba6adaa2dc989928e4fb773397aaee262382d6891c707a8ba834a8da6f68"
    sha256 cellar: :any, big_sur:       "556a71cf35c38f5e6c2c840973f5bc754c177f8dd77300ec821c117db04819c8"
    sha256 cellar: :any, catalina:      "f086af2532805b3babff0418d6846d22974c3a536625acd8492a7c828b839583"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
