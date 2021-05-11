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
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "e8e27a3596e72d58d3294603de1cb1aabcb6cdd31b76b390ed25a946692280bc"
    sha256 cellar: :any, big_sur:       "557ad5d775be6aa60e7fa799baad9b12cf79564fec8ade3c5efaaeefc19b913b"
    sha256 cellar: :any, catalina:      "5be22dcfd9a196c30000abfde6c24d67de72ea57ca3939ac7a69715a3dbcb8ae"
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
