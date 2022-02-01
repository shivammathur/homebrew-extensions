# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz"
  sha256 "b8f54da6bdac2dfce2137c8ff4adf2c39c7f7001a806270e07a4d0c25f791f06"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "de3854ec4512d5ee063e561408debaa71e86f8ecce8f1767eb30bbd26dd498ee"
    sha256 big_sur:       "f473377640c00d2c47548d021641855e2253e57249978599c7c5560682471982"
    sha256 catalina:      "a2901507018327713dd42e709127ed8463e51b418f1d0739227ac7fa3ef25815"
    sha256 x86_64_linux:  "13589e2171a39c3e403a8156e68c12a2ae2ed9d324e2e013125d53b56c351768"
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
