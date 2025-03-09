# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.2.tar.gz"
  sha256 "3659538cd6c3eb55097989f40b6aa172a0e09646b68ee657ace33aa0e4356849"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "adccac701671b7c223db8f15adb74ce6f32306b32a74877dc4094af7456dc027"
    sha256 arm64_sonoma:  "0f80370ada8aff0fa88877a1e7f5bdfde297f6da116555d162020987a28822c2"
    sha256 arm64_ventura: "74c1333c4e1be30f5f30bce0bfd128ede3dbcb684ae3e8d7c817998769cbbaa3"
    sha256 ventura:       "2251855195df7da9114dcfc33d4a5374f0527028dcc40fc7259d8244537be724"
    sha256 x86_64_linux:  "6851154634e52648c3394706decec0b8ddef61611e26065eb45f1ddfbeeb173d"
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
