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
    sha256 cellar: :any,                 arm64_monterey: "59dc0d56c05b521aa56b18b46dac74a9f3ab084ff68e9e0f389bb602ffc77f3f"
    sha256 cellar: :any,                 arm64_big_sur:  "3d24723cf0e140bd6519b1f33afe42b5cfe940f4ed2670d963e4e69e07f26d0c"
    sha256 cellar: :any,                 monterey:       "6417f5b1a0f3951d5d0179797daecfe446fc140b87928066b066a72d16939656"
    sha256 cellar: :any,                 big_sur:        "3eb7594e931ef503a627819c7f77ec7c9f2c618ac4f2db827999e46dd54495cc"
    sha256 cellar: :any,                 catalina:       "3abb164b6a14a62a12956c041770b613280738997ae0e6f942fcdd1ee57cdcad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "049d87c7d085cae2c781765496c57a80faea3ff249481765f4e4f9ffbac8fa38"
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
