# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0alpha2.tar.gz"
  sha256 "3db2ca7b20830b790e3a4ddca93a0cbc12bc768beeb50b930c9cfc0b4874846e"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_monterey: "2d4de149740ce5e6c8db6842323cfa2386d210b172b8285635cbcb0939ced977"
    sha256 arm64_big_sur:  "c1e39a0dd328e98de43836007d3093134a743bfb3e7e36e985d326c894375572"
    sha256 monterey:       "f5e05fec3661a9b2b9ffc7364fce395f1e1b654eec64913b0fc97a2a50853038"
    sha256 big_sur:        "03360073aae2151ffbb62f8475a61f2ee5c3f2d2b8938221ac9157916297a35b"
    sha256 catalina:       "13a91fa561a92583206cc54b6ea6e8ed0926e453d30838383833bb4d84a0acf0"
    sha256 x86_64_linux:   "ffde282936834ba94ec37c562714a08ec5372e0f55b38d3223b6c812ae7eb38b"
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
