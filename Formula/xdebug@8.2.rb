# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.2.tar.gz"
  sha256 "57cd63b25649171218c749f8fed808dea7d641bc4fbb4427356d00056ac24c68"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "a5e41be999a3e504d4abb8c664170e0b2168e4a5111b5eae65f95798a637a028"
    sha256 big_sur:       "d5ff6adf07e494fdf91557fbacf38026826136742cb0729595143a91ed140517"
    sha256 catalina:      "7ab972125b62e1cc7b852a774694e378399e63a593144f441cb8471e9a22e3fc"
    sha256 x86_64_linux:  "7ad13f2b014a4d4a838fc5c2cbe21bfad2784fe3b26dc4943e990449e6663149"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    inreplace "config.m4", "80200", "80300"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
