# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.1.tar.gz"
  sha256 "f8d46e0127b4a7c7d392f0ee966233bf5cfd1ade7364cc807fe5397c7de0579a"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "484bcd3d22b1e3d90f426ad06d386ae86b4087743332412ac9a24503ccc7826b"
    sha256 big_sur:       "a46a6e0b3a80ce60c43dd93cf0347ee13815c46a93bf93a29f09e431ba5ffc8b"
    sha256 catalina:      "02d1df30398da95c148c0e8f0c529153be704a71ac84ac0ed5264c3ce570752a"
    sha256 x86_64_linux:  "3af59268e81eecf4bc2a6efd81eccba67e1111722b1684af54aa7b701deecc45"
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
