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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_big_sur: "3af6a2bab92d6887e89514fa0a083c9cb5fea6e62e8c0e490bab05ffce071584"
    sha256 cellar: :any, big_sur:       "e813aacf627a51e5bea9bf5aecc2c928663eeea465b3f9b74da49637534d5656"
    sha256 cellar: :any, catalina:      "ff364480cddf26517de9a4e520a0807738138fd5f505acf58a318dcc4d02f93a"
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
