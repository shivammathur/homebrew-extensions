# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.0.tar.gz"
  sha256 "c8e447d2f81918811f93badf1a3737695e1c01f4981b5eed723f005af41ba2ca"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "8a1b7c7db71f81e326c11b67fa735c48558562889de7063edf69be6d0917d147"
    sha256 cellar: :any,                 big_sur:       "8c1f3275ec2419626408610d78246abb7539d97e7326630bc9004bf174f7c1e0"
    sha256 cellar: :any,                 catalina:      "73c22ccea97d704a565ba1ca98bff6b8e02dcd68a688171de9e968c052ca61bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "594b901e84b5221d378d5e3a130020454d5b2d0e4ed7b17125c04915ebfcce2b"
  end

  def install
    patch_spl_symbols
    inreplace "ext-src/php_swoole_cxx.cc" do |s|
      s.gsub! "*filename", "*filename, zend_compile_position position"
      s.gsub! ", filename", ", filename, position"
    end
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
