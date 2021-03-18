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
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "cd77ac55260624c68e8f9f1383356acd15f8cbcf388d28fa7cad23726b8be33c"
    sha256 cellar: :any, big_sur:       "a64000e60a812c4b7166e2363241716ad05c901279bcbbc8b6a7cf6573f80e82"
    sha256 cellar: :any, catalina:      "d7caec05abc6cbb66cbbe26a88606e6726d6ec45fa261e31952aa81e680d14a2"
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
