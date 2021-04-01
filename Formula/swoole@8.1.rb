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
    rebuild 3
    sha256 cellar: :any, arm64_big_sur: "09895d8993a1e7e4250087f66fb24b840924c94ae954ba6a9ddd1edae50dad70"
    sha256 cellar: :any, big_sur:       "a43051329fad400741c44c6dd598c4a670f0a3df88bf92a5a6c6c2dff2747705"
    sha256 cellar: :any, catalina:      "9c4c8cd0c8bb08235f2a2f7005ade3344f4b17e0759bc24ce6309e9b7ea900af"
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
