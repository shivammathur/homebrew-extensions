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
    rebuild 22
    sha256 arm64_sequoia: "522fa71659bdb7cf56a6bfb6aeb0144187dfce4fb0edbeff738b5fb2319b531b"
    sha256 arm64_sonoma:  "ce6892b72032697282f268081c8e7efda03cfa3c14d3a3cfd6c74c528b59f1bd"
    sha256 arm64_ventura: "23712502dace87efd0c472b99eb73c3f0f543ac16b8dcd75e7b3efe4a37d19a9"
    sha256 ventura:       "dc7316f00da1310ae0233759e44bc2771e0f8b9178ae6eef9a0c7f5e732cc979"
    sha256 x86_64_linux:  "dc44a22e57d2631531c3039de1033cd162a78223fcc298acc6bdb45191beb094"
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
