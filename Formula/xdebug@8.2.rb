# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.1.tar.gz"
  sha256 "f8d46e0127b4a7c7d392f0ee966233bf5cfd1ade7364cc807fe5397c7de0579a"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "a5fabfc1a181a3d64133d59841ff27b74746a5b4bb8be45eb7ba4630c30ca399"
    sha256 big_sur:       "5743a0a9997e706012c616eb12810e42b27f8d63eb2af57315471a211c1836df"
    sha256 catalina:      "12239f2fbb3522029fcef3310caccb0bbf47539b00b6d7e0e6480913c6f0f9b1"
    sha256 x86_64_linux:  "25595f133c8ff30345e2c80ced1d8864bcb355351386ac464a526bb5e639ad73"
  end

  def install
    patch_spl_symbols
    inreplace "config.m4", "80200", "80300"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
