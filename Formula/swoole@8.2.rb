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
    sha256 cellar: :any,                 arm64_big_sur: "0b9eed5c70bebbe2cbe6d2396ac52161eba8fa1bfe8ebae638fcbfd4120cb49f"
    sha256 cellar: :any,                 big_sur:       "d9fa01b14bcd76cd07889729e90f5167e55b8f3e303339cd8dc4d928dfefc219"
    sha256 cellar: :any,                 catalina:      "ca6dcd020638f448a7fdd2c98a4d81b3a8b2e0c3bd7776ef6b796795a20c5ef6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdbdf49cfe3d14e361b2ff05a920a82553691d63333d4afe23d8c6735ab1617e"
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
