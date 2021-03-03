# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhp72Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.3.tar.gz"
  sha256 "1143f8f9677c677106e846f0d22fc82f4ee5ffb52bdd1498a28cb0748186a8c9"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 arm64_big_sur: "082e71706e48426dbb5a3e9cfc39b663d1ff5d0a2b1c1382c0e8fe86be362b6f"
    sha256 big_sur:       "1f0c29900a2f6a7db0b2d228ec96eaf62b1e8b3b4ff67b051d7c58477f81f187"
    sha256 catalina:      "ae66070daadb5889e0c6551511af0d03c8f0681b8901126f2a0498d2bd75bfd2"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
