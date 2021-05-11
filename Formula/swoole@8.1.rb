# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.6.tar.gz"
  sha256 "8cd397bda05da1f3a546a6c537b8896e668af1ae96af8b6c4b2bbf8af57c7dee"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "0366bda911f5cce91a6c40094de685b76f882c82658f21f8552d94214916ce66"
    sha256 cellar: :any, big_sur:       "d0861db005b1134691e1c6a0c3751ed315ef4f85d2301c4e1aa283ae1034ff58"
    sha256 cellar: :any, catalina:      "00f0e154c9fc88c0e79fc21ac03c2e1750925049e06977e717a5ce08fb31732c"
  end

  def install
    patch_spl_symbols
    inreplace "ext-src/swoole_coroutine.cc", "const char *error_filename", "_zend_string *error_filename"
    inreplace "ext-src/swoole_server.cc", "? PG(last_error_file)", "? PG(last_error_file)->val"
    inreplace "ext-src/php_swoole.cc", "arg_count = 0", "fci = empty_fcall_info"
    inreplace "ext-src/php_swoole.cc", "arguments = NULL", "fci_cache = empty_fcall_info_cache"
    inreplace "ext-src/php_swoole.cc", ".function_name", ".fci.function_name"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
