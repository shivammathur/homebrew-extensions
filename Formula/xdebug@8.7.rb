# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT87 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/64007df3a0925808022fb87b6c6f06febf058ee2.tar.gz"
  sha256 "375de81fecb552cc2c66768ddc510ff43cc267e2276dce17b9a2e52efc73a1f7"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_golden_gate: "bdeb5e93d983006eb6a32e73ee6c0be1a7194da8e56d6d0530d245e4f04cfddd"
    sha256 arm64_tahoe:       "ef17c619bdc4df9b106dea7ff1208c02d237702d1c96b216f9795224b8da06bd"
    sha256 arm64_sequoia:     "e61f423e9128a724c22b1518ef4916e79c1591a4b2c66b9c6bcb284ef2d9e492"
    sha256 arm64_linux:       "68ab8017c4c5567c9ff78c261106717768e977791373113bb13c6c0c35d761d0"
    sha256 x86_64_linux:      "bd0f6eab6438d167f71dcab0df74b98bba31747985ea54e036868e3debceeaa1"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "config.m4" do |s|
      s.gsub! "8.7.0", "8.8.0"
      s.gsub! "80700", "80800"
    end
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
