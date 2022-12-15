# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0.tar.gz"
  sha256 "a5979f2060b92375523662f451bfebd76b718116921c60bcdf8e87be0c58dd72"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "e1f7eada37754c614b37119b528f0f4cf91b42a761b30c65868c82488b26b3c6"
    sha256 arm64_big_sur:  "15bbc1cb7313939ebb50e1bd083c1327e8b6dc8bb7b2abc33f6bb2e0902eeb3e"
    sha256 monterey:       "95e280dede80a518ae8dac374e4791aa3238b44024b0404844d3d1b2253d0335"
    sha256 big_sur:        "40c30c2c5d1b1aa8e7a77e9b61a5da27557f4a46a07d1293060c90c2bfc4335e"
    sha256 x86_64_linux:   "c31afb64c0782797f6a8565d2c0214d3b94115657054bf92d4bb12286fad4e88"
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
