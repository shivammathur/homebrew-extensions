# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.3.tar.gz"
  sha256 "988f518407096c9f2bdeefe609a9ae87edac5f578ac57af60f8a56836d1e83a8"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "d2c034f2409cbbc9a617e9364efa6d4f438b9c87b1e221a15dbe6c5ebf6c6f82"
    sha256 arm64_sonoma:  "44bdf580e7ad15298b6405d2424bcd2b7333d559adb9183f68cc6a06ec74daa8"
    sha256 arm64_ventura: "bc7fc5e414262218c601a8051b456760e24e996f874e719882d3cb2926da28cd"
    sha256 ventura:       "036248b291c045e08404e32c4ef12ea970a89fe956e9895ffb5baa47dd1e8e02"
    sha256 arm64_linux:   "3754a39b9d1cb64e7b64c0991ebb63b7f3f64ae704dcadea3f9aceef21696833"
    sha256 x86_64_linux:  "d207e5f91de52371311756516013ab7c54099a8bbb380608a0f34d7ea02b38b2"
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
