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
    rebuild 2
    sha256 cellar: :any, arm64_big_sur: "cd86230e67ae0dd1562e1e825edd0bc6e7a0e70659860bc61f3298cd676c0568"
    sha256 cellar: :any, big_sur:       "9c6d1e7dffc064e32749a92b7a589a02b43bb31e1a04a01c27131aaf02e71bdb"
    sha256 cellar: :any, catalina:      "f1a324d6672e2c98d92c0a73546d97076196ffa0fbc89de2053e05bd9042f031"
  end

  def install
    patch_spl_symbols
    inreplace "ext-src/php_swoole_cxx.cc", "_ex(file.c_str(), ", "_ex("
    inreplace "ext-src/php_swoole_cxx.cc", "zend_file_handle_dtor", "zend_destroy_file_handle"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
