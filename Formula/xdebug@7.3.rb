# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz?revision=1"
  sha256 "6620bf33db616ba52cc6b5976265d8962d8d23321ad5fd63b862c8d47eb5152f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "844604bf4c7f886999da2df6656e550ae2c88efd523e0ca0c67df25a980d049f"
    sha256 big_sur:       "6f1e93b1c3593eba1bd006841d658b2c1e62701f6bda568ce88c75b16913e821"
    sha256 catalina:      "b42d857302e6c6fb626c84e6a5cfdc8dde4ffe90e011b0baa9f92f68623bccd4"
    sha256 x86_64_linux:  "d186c5c33436f6596a291ab4d777b72be3c43daf9d798b72dd36f25bab52d3c8"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
