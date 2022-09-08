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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "7f235f3737b951adced05f246714c0b6699966cd79d67f45310162c4de1d8b91"
    sha256 cellar: :any,                 arm64_big_sur:  "4b27b8b37dd7ccf401f618cc220879a017038c2d45a960c285741b11edc95464"
    sha256 cellar: :any,                 monterey:       "0af3563526f44aacc634537b3f2d1285c98cd2ea4ad31d22814aba5c6b1f56dd"
    sha256 cellar: :any,                 big_sur:        "fda21944ff2df1e6493bd2824fdbd04681a80d1e6f900b33c2835ef6860e3b50"
    sha256 cellar: :any,                 catalina:       "c3c33775996d7bb52f08bbbceac9273d6794816cbbe9668888815814f86a622c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66b3059057612bbf6ac4dd0f9b94268ac48d43a0a40e7e06a6d7d3ce0c63dfc6"
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
