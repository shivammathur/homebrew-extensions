# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhp80Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.4.tar.gz"
  sha256 "fca3337a269db0533c0c7db10b48aeb9e6e5d7b84188d17ac59576b3f365fba3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "5de13b666b9722fcf4ef98c5328de74ddc6413d09e8eae7f686bebd3e4b49c3b"
    sha256 cellar: :any, big_sur:       "56c9750d386d94377fac5e1cf2592192d034517e208b4687aaa3da201db1f618"
    sha256 cellar: :any, catalina:      "45e831d19e8d214980cdbcb19fdf50391f92a0aa5315be3dad8cb22cd16ee03d"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
