# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.10.tar.gz"
  sha256 "0bf908cee05b0aafec9fbbd3bf4077f1eeac334756f866c77058eb1bfca66fd7"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "a1011f2d79ac3b3444065a40b264ea1d9a681193c69df893e1c79b120d91fe96"
    sha256 cellar: :any,                 arm64_big_sur:  "83afbec91ae9f42e543249717251e007f54ecb473714b15a5f0d4d7ca67663bb"
    sha256 cellar: :any,                 monterey:       "ad143d3568458a9f01b79cf5f40a72032661c770037a0f44fa495630788ea404"
    sha256 cellar: :any,                 big_sur:        "36f76673e3ea2139b110e174a3b9225673411fd430066e857f65ba66c45924d3"
    sha256 cellar: :any,                 catalina:       "7fa5d2bb001c8931287fde52fe53f7a49baf2b31007c4d66d762ed911431fc6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eab5be24073e1df8581467bee45d59e3c6b61d02715da86a02ef83610fbf0bc0"
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
