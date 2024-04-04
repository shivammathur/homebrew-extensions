# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/ee60cd694186ce1c0f5f52b46d72dc8fc694859f.tar.gz"
  sha256 "efd6eb49b29a3d7d2915b2f319e739a4d9bca324369fdbabfdcecbdbc7c9544d"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 arm64_sonoma:   "de513871a45bf625bfde607f703a2131b31d85da35851501ac03dc19f9244d9e"
    sha256 arm64_ventura:  "9586eba08f9caaaaaf2b530e08e4247ec803e3a1c61d7ba4a09f10fb601657c6"
    sha256 arm64_monterey: "b2e6c17f9f4f476e4f43a6d94b34c4ff211c3008a2c5dea46ebe7451c6d54284"
    sha256 ventura:        "e37a2f7d64c422df3984c445281610c7948011f86306245b14aa404eb57e5feb"
    sha256 monterey:       "e4b2a6c8f09a4c95f9d3ca5b6dc78545f0410ec8a47bb66413abac88f2a9d8ff"
    sha256 x86_64_linux:   "1fee9ee2a64b5ad29bdb710397d62d86527de683fb2acae8b723cc6aa8738324"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
