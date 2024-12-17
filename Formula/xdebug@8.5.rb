# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/35baf95fcef342e7f02119275facf433ded882a6.tar.gz"
  sha256 "2c652de735f92e3a367ab0e594598a46b665762fb3642e9468fb51d7124fe0a7"
  version "3.4.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_sequoia: "8d3bd99c39d17a010ec84eac43d27dfbd5f5e11b12019fc2930dea41bc06f34d"
    sha256 arm64_sonoma:  "7a8ec6987d8ba57db3972ee4854394d95780a90e7b07a6b3e590493441d8d950"
    sha256 arm64_ventura: "c33f1b606b8f66624b54f3152180b288a291a955a90dd7ca3abed1bf3c3c2e50"
    sha256 ventura:       "8c56b5a349aa86d572f9c378a95cc48d0280070f09db2c8d4fc099e3465601ca"
    sha256 x86_64_linux:  "60eadfe558a07848a1b0ceac5ebd66ffbaae4ba1232ea23ac8f1876b2d86ee2a"
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
