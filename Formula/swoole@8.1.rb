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
    sha256 cellar: :any, arm64_big_sur: "e5668e40b5d87b287e5a3d2f34fc5563abd8d4fd7eebc4d2e36d8bf6e42d4863"
    sha256 cellar: :any, big_sur:       "06ad2e3120afdc68017e0e99ee61cc472484142cc10844dfa75635bffd90932f"
    sha256 cellar: :any, catalina:      "5d61b9ee4221b4ba27b83a7ecd01efafbb2bc395e03ec064693f42db13b0173d"
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
