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
    rebuild 21
    sha256 arm64_sequoia:  "07d2403188a9bdb1819c50cc41d2c698020c308110a7a53ed5aef26a4a650174"
    sha256 arm64_sonoma:   "72a8c87fabe97e70136a7a2fdeeace78dce175b8c113b8b49372054b28178efa"
    sha256 arm64_ventura:  "506c922ef87afb720fdc8a2b284381039ee98f9b687fa3f88cb57ab442eb9c62"
    sha256 arm64_monterey: "68bfca13f999cbaa07ab9befb9bb3c914e4b110b47fe47e9ccef0554a90c9861"
    sha256 ventura:        "5c2e1012f507f37eec61ca07a5870ddfbd09ec44be84803aec612990e22ef368"
    sha256 monterey:       "2d9088dc3a1ad214a5005f3d391e9d58fbbe0cf2519f9847b4fa6c56727baee8"
    sha256 x86_64_linux:   "b5097cc4b5e181853f1a47cee28e4ce13204117a5b861e1a591146e87dcbd96d"
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
