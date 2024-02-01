# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/a27262d63ca93117e6cffe2e617731be13030165.tar.gz"
  sha256 "c36e3d6dcfb2ca847a5c3c7975657f55f8ff654deaac664016f220a7ee0b6948"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 arm64_sonoma:   "777f17135044406c660b2d1a4b3100d0b33fd2d2a40b1240a0d37561634d2f33"
    sha256 arm64_ventura:  "6ae7a3f2953c6098cd2dfa5d714cb7b1e9336f610d344cc0cea815ca84fa2041"
    sha256 arm64_monterey: "5e39e6b10efe95d9b7daba75fa832873a9f5103b1bbc762032cd919524b56f45"
    sha256 ventura:        "954e6bc66827b4a18da1de47c2b04d07684135c470263027fc8e20d8dd538514"
    sha256 monterey:       "89c2f556e84e7ae063a5869377c4013c8dd46631b03e51de1d6f528794130ff6"
    sha256 x86_64_linux:   "1302310cd9d896b80b3190c43df3a61eea51cd8912722812bb32ec37e04bd8f7"
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
