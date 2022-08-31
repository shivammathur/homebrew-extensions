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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a94426c64c33335972a59a20d962fd31cf349ee5e862ec5091801c12df1be093"
    sha256 cellar: :any,                 arm64_big_sur:  "e0db1659160ec7c05170888119128342840344ba20e82ea95f0f7d669bc499aa"
    sha256 cellar: :any,                 monterey:       "30593d818d0eaf724cb279009a72e079a84e28db4939ee535308a25238074422"
    sha256 cellar: :any,                 big_sur:        "9f7efc054a786873000ffce87aa6b97d1318db825551f8d46617f207f6172cc2"
    sha256 cellar: :any,                 catalina:       "68fb008d5a008e1ed3b4cd2b0c4ea4aaf83cf9e63bfafb9c5b5ab96db61c9141"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cd64010bce3805793af0f6ed14065499ce5b3a2ebda2135e21fb53dfc4a625e0"
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
