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
    sha256 cellar: :any,                 arm64_monterey: "e849bb58d0235ea0ca616a7e61447fe8cb9fbb36ecdb2f2f672d47be7059a486"
    sha256 cellar: :any,                 arm64_big_sur:  "586491c36a24d8c0cb97bb5a478e199ab8b782b368c37506d5a627ac8a4e7f03"
    sha256 cellar: :any,                 monterey:       "fee94864a317fe455dabdad9b3c55c1faa9277d3b89c1b8975d50a335acce9e2"
    sha256 cellar: :any,                 big_sur:        "a4a7d78e985d2469f877e2404f73f6fdb0ba94a0b42df4519e849ca712471e45"
    sha256 cellar: :any,                 catalina:       "45d310918feb08faa7e9c98b490583251b714e8763c77df97adb07cbd6c55a60"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca9d8a2c3dded9194b072220d44f1264c59c0eb55da45d52b6fa66af6f352856"
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
