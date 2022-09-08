# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "69edce8ba789bc38a327c4fb248d0126b7da49628afc2ce27703bbcfac34325f"
    sha256 cellar: :any,                 arm64_big_sur:  "43d17f6631cab9e9aa11bf07d3779f8e74e5a18ddb9219d79f39b15d7f3e00e8"
    sha256 cellar: :any,                 monterey:       "09ac02764c0ed3cb4527f73c71aabf3a0c07e49be1c2615cd4be260729cb5103"
    sha256 cellar: :any,                 big_sur:        "8f4dfe9fa2c1eddf0c804401068aaa20871ad9dfc2e9608d1d6f7f0041efdf68"
    sha256 cellar: :any,                 catalina:       "05db17c06b370da48aba496cace7290d728290e645392c748b7be04c80ebfac0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "64cd22dd260482ec6845882834e7afaea4c9c918263af98ea94bdf2d744ad449"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    inreplace "ext-src/swoole_coroutine.cc" do |s|
      s.gsub! "zend_bool *zend_vm_interrupt", "zend_atomic_bool *zend_vm_interrupt"
      s.gsub! "zend_vm_interrupt = &EG(vm_interrupt)", "zend_atomic_bool_load_ex(&EG(vm_interrupt))"
      s.gsub! "*zend_vm_interrupt = 1", "zend_atomic_bool_store_ex(&EG(vm_interrupt), true)"
    end
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
