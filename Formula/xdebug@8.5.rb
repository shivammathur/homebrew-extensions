# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
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
    sha256 arm64_sequoia: "b7c6ae02bbb1120e20b994901d8c37350c57be91dba5f5043dcf5f2fe39919cc"
    sha256 arm64_sonoma:  "861b4d56272115e17c76cdedb073b2ffaff8aea4f91060d5e27d4ee13f4a8adf"
    sha256 arm64_ventura: "d9379c33de7e1cc0d43f733db246d23ff054efde486b29f7ecb53b7a0301d3ca"
    sha256 ventura:       "2df6b04a6c2863cdfacd87a64e608ac9888d5f71d0daf953a3704e7ad32894c2"
    sha256 x86_64_linux:  "9631e6eae2a6f8ff5008a72517e4e467c56b5abffe5e733e98ea45528a00948d"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    inreplace "config.m4", "80500", "80600"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
