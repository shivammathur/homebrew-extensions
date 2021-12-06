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
    rebuild 1
    sha256 arm64_big_sur: "25f3dc9e7ff2cd8d6f60ab435f4c2fc5ef9a3363d94c096b703928542328c77a"
    sha256 big_sur:       "df4f26f0b96bbbf09200f79b467bd022228192fdcdcbe2d2b1a8b4b1d4b79f63"
    sha256 catalina:      "042035b35b7fc1a8daa67ba243e0c4dba5215f77436a30375064599e30177e9f"
    sha256 x86_64_linux:  "8f185259d8dcba76693d47bc92cb70bd4fb393a8baa46e341bb78dce407df4c6"
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
