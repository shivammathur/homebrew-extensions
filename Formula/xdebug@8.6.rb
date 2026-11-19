# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/5e19866c1766e38c527f9f94faa170370dc4209f.tar.gz"
  sha256 "a11d140cb67da8920df0a063c4d77b893b71b0195bb96f871c5f5915e0544ec8"
  version "3.5.0"
  revision 3
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_golden_gate: "ef2cdc1b71c4dc178fbec115bad1c6c704b7b80d3ec13a45aefb0dba0a408a9c"
    sha256 arm64_tahoe:       "6341a2b38b0d1df8a8017317f43f12e4820a118318684995ea98154c5d822441"
    sha256 arm64_sequoia:     "c7f9826937ec58fc58ada9f1b6a52f417f9c3576389f1c059d91f86438647ac6"
    sha256 arm64_linux:       "77f8e5e48adbe21c284b5e800046d818e4b75d5d7ea6fa0c94f04d8c88f15168"
    sha256 x86_64_linux:      "4230a5c3d750d4cbf8e178ce413d6420346eb4622ce558d0a28040e70945150b"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
