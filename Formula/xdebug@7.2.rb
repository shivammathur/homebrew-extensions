# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz"
  sha256 "b8f54da6bdac2dfce2137c8ff4adf2c39c7f7001a806270e07a4d0c25f791f06"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "845ad4f6e6537634ef49c4562ada05f42e1bc0ba198278cfdc64374ab432fe01"
    sha256 big_sur:       "1d22ad66fa730ccc1d1ce70a1a219062b12bb137a8908bbd4d31835cc9a05c71"
    sha256 catalina:      "2894f2247eb00b180243793740d83b9125bcb4e2462873a329f806a1fa3d9b42"
    sha256 x86_64_linux:  "b2c3b0d6b5e2b6a67c9314f51abd8616eaa7fc15c72ca7fb045d887d15bb580e"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
