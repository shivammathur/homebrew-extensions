# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhp74Extension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.4.4.tar.gz"
  sha256 "8204d228ecbe5f744d625c90364808616127471581227415bca18857af981369"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 "0c42e2561a837b9c6fd0f04324e74ced044136a65c2c88d0a152c15ba8f89fc7" => :catalina
  end

  depends_on "imagemagick"

  patch do
    url "https://github.com/Imagick/imagick/commit/b4e676607c23e3b280d5312c0cd2d79786772547.patch"
    sha256 "3aac4980d1d38ddca16e0469ea257ec6405474ee8438b47d4c00aac94911cc49"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file
  end
end
