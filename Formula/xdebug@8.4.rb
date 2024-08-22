# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/12adc6394adbf14f239429d72cf34faadddd19fb.tar.gz"
  sha256 "67bc7b1ec133a1a38dc9c23c892878bd2a0a308833964fccbae897b58aa6fe88"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 arm64_sonoma:   "e2e24c2525d390a378464fd8ac4e3f5f52a43fc8ed6c27c452e87d4fa04e144b"
    sha256 arm64_ventura:  "04b5bf69e624fd186fe07d0369fa89a59128175646df11d6ce112a112d2d7fcd"
    sha256 arm64_monterey: "66b670cd8a4cf1e521307ab3089d066fca2e549251f19354d39a6697d0db1744"
    sha256 ventura:        "f3569443eb37cb17c8c4221b52e748294a6a7bc7bc063f9e6cda1b70205bb25c"
    sha256 monterey:       "1e880c626985cfd609693c3bbd5a7b01c1885dad0dca21a8e383778d6cb2fffe"
    sha256 x86_64_linux:   "3da78b4098356876218a527cad4669ed24efa5fcfc1b5a81edab93ee1812557b"
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
