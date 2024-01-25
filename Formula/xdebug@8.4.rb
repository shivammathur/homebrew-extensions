# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/70e8452db0171456bcadc64ff547bc12b6557464.tar.gz"
  sha256 "8245dea42f7945bd53ffa61be6b3a54ea5aedd5cdc43ec64d00d85721af5d5ea"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 arm64_sonoma:   "9a0dd2be64a2ebf33cc282e5e58e387417116768ea07db04a0e7c22abba51e87"
    sha256 arm64_ventura:  "b45eb3ea7391db5e38b657d4eaf6d882f313312de9d33b7e48d748746f7c1c87"
    sha256 arm64_monterey: "3be52214619dabaff28504da90c6ced2c98b82c3de702b75889a027a2854c220"
    sha256 ventura:        "17fdf808552515a61ed7043ba5ee4ab1c110a75ab3c0ff754da7447f2527336f"
    sha256 monterey:       "357560285d0849de4fbe70d7d6ed9fee2ae19439fafa04ad945a5371d5031997"
    sha256 x86_64_linux:   "96d5dc0c09638e00e9b6dadcf1ed3f336615c2f5c2d726a3748ea243ea729f05"
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
