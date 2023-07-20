# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "8253974018921d70ef02638e1b34337a7a881e81b8ed8d73a658e3c3d36e4d7f"
    sha256 arm64_big_sur:  "657f552055850354224a84603b2791a7126c415f488e1f05af9b552afa8113ff"
    sha256 ventura:        "3d4131ec9a5034cd2ee6228afa58e0cc37d2d6f3bc8c5bd9c5dcff6a6a1e1ba5"
    sha256 monterey:       "c8d7fd00dc12110f6f4b062f88b79d89ceeb166796005bdef1e96e4e6a48bb10"
    sha256 big_sur:        "57b4f60d9cf57e4568020378ce124d9e390829f31d9b5556958e81c08e443b80"
    sha256 x86_64_linux:   "f53265922692088d66790f438fb4098b745cabcab682d8dcafc4dc9eb7618f1f"
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
