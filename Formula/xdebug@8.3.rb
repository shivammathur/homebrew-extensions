# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/swoole/swoole-src/archive/v2.2.0.tar.gz"
  sha256 "1baf1b12bb8059f6adff9f81e9a10da893a37a2f5fdacbc9df9baca5681852f4"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "d70fed784753579f2e3a2a80e151b4e20b599d8b3ccb7dee2bdff2312dcbd711"
    sha256 arm64_big_sur:  "72cee1b23f108ba2f90e4c6d456e932392883cfb990d9daa33574d90d03eb738"
    sha256 monterey:       "5628ef280f473d20e4c1e6e0660c29fd36b8ab698d4fb1b49e8b23ee049d82a0"
    sha256 big_sur:        "cd2c07af920b4bc21b252154c637c9c04c68a916b3f95cd32e5b199eb8d32b59"
    sha256 x86_64_linux:   "1c9b9ee3b9c42f67b3a4560549ec603892c9e8e6d792715070f2393b87a79dc7"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80300", "80400"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
