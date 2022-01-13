# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.6.tar.gz"
  sha256 "0234d336dd19f56b7e175dddd7ce61b17b00ba24426072018d781c9815c263ac"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "c831a023ec110a7a94cd4ad575c991c1e362cb2e925c6709d095da00bc9577c8"
    sha256 cellar: :any,                 big_sur:       "841c8cd28950046054a4e9bfd7518308b3f9435e2a600d408fc3d817502436d0"
    sha256 cellar: :any,                 catalina:      "7c6b7fb5c1b4ff724280da5e8e7c0a1f57db1196cca4d59c04a78d767052aa94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04d57abb43e200f03eb15c0fc6a7ac84a464fc0366e25e56d60d1dffe2430b69"
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
