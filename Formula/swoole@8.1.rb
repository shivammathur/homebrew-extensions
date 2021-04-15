# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhp81Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.5.tar.gz"
  sha256 "c93f6a0623b90ca6a6c96f481e6a817f2930b4a582ca0388575b51aa4fb91d38"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
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
