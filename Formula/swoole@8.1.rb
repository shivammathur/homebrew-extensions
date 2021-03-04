# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhp81Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.3.tar.gz"
  sha256 "e93fee47c66cce13852d52e074a211d352f05f5c2644b280f653242d87c6159e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_big_sur: "89b8f5810305952642ee33e2880370df27a8da96604b19db2614d3757ccdbb7f"
    sha256 cellar: :any, big_sur:       "8698058244fe0255cba9a0b91210693268d86f2e59c934f49ecc45ddf1b162f5"
    sha256 cellar: :any, catalina:      "c1548d9463efd2284a73eefc3b8cc357fdd6fc84c83dbcf9864eb518d7ad049b"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
