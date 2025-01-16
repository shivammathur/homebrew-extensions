# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.1.tar.gz"
  sha256 "9cf77233d9a27517b289c66e49883bdb4088ae39056cd0b67c3a1d8596b21080"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "6f9ac0533b22f7e58a712962977623c7006794abb53dd58c05d583ca85948503"
    sha256 arm64_sonoma:  "b7e3845e27c7f52d6e109cea5e9298b51c0845720e4a502a94a1ae76cc22afce"
    sha256 arm64_ventura: "1c2dcc12e0f2ec1bec1c3a675bcda1a9e1f2fe9217a5d8e44834f5456a4f7e33"
    sha256 ventura:       "8fbe33c68da22dd49697fa324d7c101090ecbd27d3d8f6438ae4e461a8a10442"
    sha256 x86_64_linux:  "c53fa2b36d93ba32fa590100abc9d4f9a8708dc6ed69d092228462981e25fc2e"
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
