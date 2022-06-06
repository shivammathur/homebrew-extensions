# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.5.tar.gz"
  sha256 "a74378597a29b6393db52b23698f2cf17b8dd589f032049e252153edb868213f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "457bb7f6f95d44acfc45e30b0729fe6483e1e74c3f665f3d678195f0a0e4eebf"
    sha256 big_sur:       "2d3d4e9af4f78297e549afc52eeb23ef2b9168c7446229a137268683e03c43c2"
    sha256 catalina:      "bd3ee927a6298fc0aec4836de159d6ca736542207d32649235cb572b24bf1e76"
    sha256 x86_64_linux:  "e03708d4a1b5f60b6cc9bb1d21df8ebbad99cca426bace56304ea0c1e0aa4110"
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
