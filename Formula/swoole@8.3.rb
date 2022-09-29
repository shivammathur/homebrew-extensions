# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.12.tar.gz"
  sha256 "ac0f5b3cb9ef2e04f0325fd4d2048bc727d545c56ae9d7525c9150b33ae55b7c"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "657839e8dae5033f4e06c6fb9e06f568f45e403881a63c3e07bd176933d55cf5"
    sha256 cellar: :any,                 arm64_big_sur:  "19ec6ecf8b4594b2d14811661d1bfec92ce94a261b54faef53681ec2349dd6cd"
    sha256 cellar: :any,                 monterey:       "bf742af329b475fc653fe96b5c78d308cdc3f8e53d9513da372892ceaad1facb"
    sha256 cellar: :any,                 big_sur:        "ba1eab837982945fb9440c0581cc3912065b10d2f5697c0ce31a838ffd4523b7"
    sha256 cellar: :any,                 catalina:       "1604ed49ad53bdab07b00a87f8dbd0554eefceca60475b13ae135c0bde1ec6d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7db3056308f0ce2accacd8486cbd277761932a037d0ad656ec39a1ffbc0ca70a"
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
