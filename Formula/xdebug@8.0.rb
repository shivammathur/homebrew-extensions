# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.5.tar.gz"
  sha256 "a74378597a29b6393db52b23698f2cf17b8dd589f032049e252153edb868213f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "7134da6ca16e5e1ad7921b72fd07c828fdd31a49871ff5d16828dfcdbb941f35"
    sha256 arm64_big_sur:  "dd6ab66b0277975380eabc78012e9c968ab9dc56169555b8c8e44e8d3de241b7"
    sha256 monterey:       "fa71f3f2ca542e21189015a1ac5c648ff935ab1459714b77275036352b30be2b"
    sha256 big_sur:        "c2d299daa31d77ae094244b78072b1199f156281fbaf5335f6921ac50723e360"
    sha256 catalina:       "10f849009e91023dd011932a7a148e0ed4a1b87c9308fcaf31da9d0fd1fe1aa2"
    sha256 x86_64_linux:   "a6bc5e12eb66770d45b870269bdd7ea1a6af2878872793e7f5ea372e71c5d72f"
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
