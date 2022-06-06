# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.5.tar.gz"
  sha256 "a74378597a29b6393db52b23698f2cf17b8dd589f032049e252153edb868213f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "1cae31ced1f5fbeb32c2f422a7bfd4abf20ca48b1c2fa2655456f00b3d05d934"
    sha256 big_sur:       "d046c064425084f6d682b2f985534979056baa7a1ddce52efcfcc7df0ae52658"
    sha256 catalina:      "32a0862829cc004023090ebbd8662e9d677ad127ebc3762a7c9d09ef9e68b731"
    sha256 x86_64_linux:  "3211fa64db4a47df03452d9de39613c4e644ce13ca9b679b8d8db390319ba4ac"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
