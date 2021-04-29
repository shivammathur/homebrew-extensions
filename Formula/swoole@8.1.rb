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
  end

  def install
    patch_spl_symbols
    inreplace "ext-src/swoole_coroutine.cc", "const char *error_filename", "_zend_string *error_filename"
    inreplace "ext-src/swoole_server.cc", "? PG(last_error_file)", "? PG(last_error_file)->val"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
