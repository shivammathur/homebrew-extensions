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
    sha256 arm64_big_sur: "e8fdb15968f5006bd5541fc81e6a0f7ec1292c4ba9f59c8d15062e21bdfde6ed"
    sha256 big_sur:       "d42ad4f9c051a49038bbc0eb698c6f2f28e9546c7a4bd822266f17fe7dcb6fc6"
    sha256 catalina:      "10512e601485f74dabcb51a911daa718e33e0ed81181f9b02dfec749870ee37c"
    sha256 x86_64_linux:  "206f07d643bf202cb16f0db77bcddec9497f7f1ec793540ba8b6d2f4ff3666d3"
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
