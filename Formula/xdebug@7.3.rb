# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz"
  sha256 "b8f54da6bdac2dfce2137c8ff4adf2c39c7f7001a806270e07a4d0c25f791f06"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

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
