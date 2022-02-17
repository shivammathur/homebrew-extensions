# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz"
  sha256 "6620bf33db616ba52cc6b5976265d8962d8d23321ad5fd63b862c8d47eb5152f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "d47c0bfadcf6cfd9607d6b4e01274994281046b9b90a6924670d899023095a29"
    sha256 big_sur:       "cb1d1ecfd40860820bd1fcabebd042e7ec11c3a8ad75a1d3bc0414f94bbf7215"
    sha256 catalina:      "77dbda31100b9fd27e7610c51445e6cdf5521ba68cfc51c4216a5c6215c935ce"
    sha256 x86_64_linux:  "03080643d8beae1ff806a1e73527b855948c8b31408358a5e68a83b482978859"
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
