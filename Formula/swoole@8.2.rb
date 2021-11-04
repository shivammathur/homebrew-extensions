# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.1.tar.gz"
  sha256 "7501aa0d6dc9ef197dbfa79bff070e751560a15107c976872ec363fee328b0f4"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "fdb37079e73bb37cc4ba6e63a9a34346662bb28b01151517c75a1076c42f2cff"
    sha256 cellar: :any,                 big_sur:       "bc13ca12d82926d632d3bf4f389f0f08b0eacc467e1c0fcc9720990794d29bc1"
    sha256 cellar: :any,                 catalina:      "3ac1b1d2d3625738376896f34f632104dbbae27d4bc83857e0f159e9f0943c71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f6ed86ac0bb4362e38e213aace9401228afae315a1c2c13d48f7c25dbb27485f"
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
