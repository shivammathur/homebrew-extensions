# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/c40edc02c3802e11412f684dfea41e9b99ab0ef5.tar.gz"
  sha256 "c372da204a30d042025b72710c554d9edb89a565a825d21b799f8bf30d816111"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 arm64_sonoma:   "d04d2f371ccd8311efe42d5724f034fabd747b041714034a54b6acd6e4ffdd07"
    sha256 arm64_ventura:  "584abf5175705fc46bbc0b0c60a8b76e401e21372b3e3db9c3341a56f3d3efc0"
    sha256 arm64_monterey: "7922842892fa0b36f32e01401b15163a4e579dac3908a7671568daef4e6172f6"
    sha256 ventura:        "9b8038a4817c1e5d8059e9bba08cf77835d92c573a2d7f9d7511732294a08dbc"
    sha256 monterey:       "3edccc36c34fc56140e88ddfe59c19f15e03ec599bc2d4e1510ee39d381cada0"
    sha256 x86_64_linux:   "9105a030d8b916a55a972c7061099642521323ab97b5ce7a57304482eb4499c1"
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
