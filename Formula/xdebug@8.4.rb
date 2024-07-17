# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3ed0dc70cc66cbce35d76aaaf5672895e6f7bdff.tar.gz"
  sha256 "39ac65fa8d839758ea8b8f7402aca889ac120faa462fa49120fc5288e69539df"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 arm64_sonoma:   "deb06b19a7e0c28b49ac5da54f8750a47834b3adaae14d50d98aa6078549338b"
    sha256 arm64_ventura:  "8f70aa27c075f41baaa86ea88ddf969e5db3b34adcbf200b16d9b9abb7684142"
    sha256 arm64_monterey: "43b7d1706c95683a8c7f021748170eb158ee55e006728f4a1e1480ed085b5f64"
    sha256 ventura:        "6664e18dda404b6812c40079e6fc3ee76b86ee343be2ece1c54564d8db48fca9"
    sha256 monterey:       "8102d855d7007167d756b0b15a1f9f3d9c13e6062cb5707ef47804487fb797ff"
    sha256 x86_64_linux:   "0f12d0ba859226b4a579570c96cc7acdb8f1d5f9ae20c02077e5bb11ebde5096"
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
