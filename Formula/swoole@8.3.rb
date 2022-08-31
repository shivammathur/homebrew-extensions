# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "44c0e8d0031161f565b1435fb060e9f4591daaf60974438c9df609d0d2afb3f3"
    sha256 cellar: :any,                 arm64_big_sur:  "2f63256d6131c6801e977460a4ac2832b79199f25f3dc7dcd25fa7760640ea5f"
    sha256 cellar: :any,                 monterey:       "bfbaad254a996a54576dad749d80a9cee9107ffc5a40cbcc68cd832139c0775b"
    sha256 cellar: :any,                 big_sur:        "4647615ff2efb31722298b7c29bdf966120e73ce1b53d107cf99d0b158314df3"
    sha256 cellar: :any,                 catalina:       "482ca0b1e7c575b0536c3066a8003ae5ec8379c55205cef2d88b3ffbde6fb965"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3f5be5682fda51861f6e23db4b8b676546e3bbdeb27a01236f0be2ad34f1b3b0"
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
