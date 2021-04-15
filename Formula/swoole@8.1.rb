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
    sha256 cellar: :any, arm64_big_sur: "29312839f495e60630c8cfeec8fbaf289e9cc7f6888d803c2945395cd409528e"
    sha256 cellar: :any, big_sur:       "b44c69352302c4f000bc89b9818c05ae5240169837b2640ee96f50e6f57d42a5"
    sha256 cellar: :any, catalina:      "7dea30410d7e8c1da54d69b738722ddfe3cac74edfc2cfa41065fa1bb806bd98"
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
