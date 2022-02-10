# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz?revision=1"
  sha256 "6620bf33db616ba52cc6b5976265d8962d8d23321ad5fd63b862c8d47eb5152f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"
  revision 1

  patch do
    url "https://github.com/xdebug/xdebug/commit/06c7f670e78fcd7867daf30d10eff785a50e033d.patch"
    sha256 "0ecd654aa184bf5974532d107d92dddd4337bac834a1c712d2dcf73c3545aeb5"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "6c2e942865b7b5e17b05ce4c1ab5b0cb79d40315ff45fe7940cd94b2e6b06c21"
    sha256 big_sur:       "65d8b7115900fcb8ff5b7928cea507cc086548636e25170acb9b49251028b3b3"
    sha256 catalina:      "0890d83443db6bd3935e215b1c972337c0bc1258aa86dd89a8add37fd530269f"
    sha256 x86_64_linux:  "9f0a378e5d30d70f6bfad0d6963e600a0227ce95c943db6af6b703b942891bc4"
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
