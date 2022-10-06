# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "9366fd60cb73e8bb2f80754277268a5774f8dd5b6650b6ee1da812b7fe5cb6c4"
    sha256 arm64_big_sur:  "803b32d7d757787aa32ac694028c35327baba6992036da752c3e3d8bee32c440"
    sha256 monterey:       "bbceba24d5856d8daa979b39412be801667407336f0d2a1f720e8f3537437978"
    sha256 big_sur:        "223134b9b344d0a40183ff4569ae7e63199824c2911e5ed71285d6c18fce0d54"
    sha256 catalina:       "445b9bba74a39596ad7ffaebabc9e507b798e46c505a16eaf506dec5fcacf02c"
    sha256 x86_64_linux:   "270583160fc88de5d2fad5cbcefc5e9d99a623476feed958c6454ebc9f54657b"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80300", "80400"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
