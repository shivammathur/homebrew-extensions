# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "8934a726608a5834170793dcb2f6ced7cc0072364bc6f170720cc4a32811863a"
    sha256 cellar: :any,                 big_sur:       "2805bca6c653991cd85e36735e31221d9b1be0ccd479cdc5909c118560cb1ad2"
    sha256 cellar: :any,                 catalina:      "0c8d1ecef915dcfd156a2c08ca985a828baa42c2a93baa4c1a015ad27fd5f2fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a58ccf61e01eaab854a8a11c143e8b47dfa54fd1adf4f4b8f747eabf554e3718"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
