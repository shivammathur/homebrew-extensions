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
    rebuild 5
    sha256 arm64_sonoma:   "19908c3c671b5ffd1669a2bdfdfca2996d3d61a9a82740b92436a84ab92b5b19"
    sha256 arm64_ventura:  "d73e69c5c7deeae817d27507b81ceead6abba828a5fd8db78a6349e17c1f3fbe"
    sha256 arm64_monterey: "d1e556891438f1fdb47d625f9fc91331abf3cd51544f693a4b5baf557068c1f4"
    sha256 ventura:        "811d228f8d7b48ed6905335d4f8f456fbae2fc18f0cbaed27aa86f1a66a00280"
    sha256 monterey:       "60fcc484dbebb9143556b277cd5acf04732b39d31f01aa754b409dff6299c9e7"
    sha256 x86_64_linux:   "1522779453adb4da8f9e13cd7f5d4072fbdfbf16e57886cb1ca80d051d4e6622"
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
