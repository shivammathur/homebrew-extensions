# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhp81Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.3.tar.gz"
  sha256 "1143f8f9677c677106e846f0d22fc82f4ee5ffb52bdd1498a28cb0748186a8c9"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "e5e1a4ce47f118d00a4b20143b08b55e25feb72a55652980fd061e50fa06ee2e"
    sha256 big_sur:       "40d3d2b5466b7709b602c4166e2596522face71950b367dfa38d5a6b07640916"
    sha256 catalina:      "64eaf1a95b707f304bcd74b42de47af26058e0d9761ce50df766cd8191f66bfb"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
