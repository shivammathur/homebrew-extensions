# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/b303190f15674d6d4b9ea047b4cc2f9000de69fc.tar.gz"
  sha256 "871f70f35ad5e73a54d933df357259f3bf79e51e10b8c6b9607045506c8b1200"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 arm64_sonoma:   "1584c0b73202276c98efc76c3e13e230cf9984a4853e319779df7be6fa3c96cf"
    sha256 arm64_ventura:  "ed14de2e1cbaaa82be3df3f550bad5cd0e4c014daef2d449c1db2396dbe9ac4c"
    sha256 arm64_monterey: "277e2a21255e2659e2fd779795ffd35cb772b09ebf2f68280b13eb32854a8236"
    sha256 ventura:        "c8f97707b9a3f72c8c58da99c442513a5927b6b1ce0eaac1bf5be2a1aa8617b2"
    sha256 monterey:       "2ad4e8910926b508fc4f3ee5bba999721d7c3a954ca4b5fc724f041481d86335"
    sha256 x86_64_linux:   "4c4c37a80afda2d6b1f5ed40bb2bd25abc89a9f369e6a59354637250775c0e74"
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
