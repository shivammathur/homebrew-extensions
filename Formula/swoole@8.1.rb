# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.7.tar.gz"
  sha256 "f64bf733e03c2803ac4f08ff292963a2ec1b91b6ab029a24c1f9894b6c8aa28e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_big_sur: "f0d7623f0693e6c3a291442888e10c93a2eb9445bd9f39f1481aa2f22fcbae39"
    sha256 cellar: :any, big_sur:       "61c5a19826fbf4b1c5338ec7415ed2cf3a4ee69d51e80e6646d49038e4848e6c"
    sha256 cellar: :any, catalina:      "35d39ba9803eb331a9fd231747f863d4046fb861bec131f6ce1fdf1416c20bbb"
  end

  def install
    patch_spl_symbols
    inreplace "ext-src/swoole_coroutine.cc", "const char *error_filename", "_zend_string *error_filename"
    inreplace "ext-src/swoole_server.cc", "? PG(last_error_file)", "? PG(last_error_file)->val"
    inreplace "ext-src/php_swoole.cc", "arg_count = 0", "fci = empty_fcall_info"
    inreplace "ext-src/php_swoole.cc", "arguments = NULL", "fci_cache = empty_fcall_info_cache"
    inreplace "ext-src/php_swoole.cc", ".function_name", ".fci.function_name"
    inreplace "ext-src/php_swoole_library.h", "Serializable, ", ""
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
