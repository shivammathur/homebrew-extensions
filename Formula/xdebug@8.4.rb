# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/e228555e0860b7c25843d75836a8b64802bbe548.tar.gz"
  sha256 "59b7ef443e2fdc244cb36df349590c867f430e7bc41b1af53aa0e8ea4f76cdd1"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 arm64_sonoma:   "00ecb2dbc2e9ebd8ffdc7db973783ee5f822faf7939c0e8d620eec010241be6c"
    sha256 arm64_ventura:  "b60e8e2f0f2ee2ccf2a79c3e8e66d857dee54d059f00a1c3eb466d2a4f9f43a9"
    sha256 arm64_monterey: "9ad155e2130c815f362d41d2f3372edf00cd99310bd187ffa9f50b106460fbaa"
    sha256 ventura:        "8120263ac6a62916a2130ddcdb14b9e3f49dfd6502147e9e5d1d4d4c05735e4b"
    sha256 monterey:       "02a03504300fa0c46b4d106e558562d0839dba7006eb9b99ed60aedf812f7151"
    sha256 x86_64_linux:   "1074c29515a52da2b2623469ab7acad541a92652f18c777c342c92a2fb92cdbe"
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
