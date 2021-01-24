# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhp72Extension
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
    sha256 "c15e4a1b34134141da350d82c290cb9190ad805a59c7b76340b9d12eb4ee80ff" => :big_sur
    sha256 "f9bd9dcee6dc6af9ebd0316f9cfb03fc304c258b4c66e8228d173ef1acf099c0" => :arm64_big_sur
    sha256 "6bb90d857c39f369b8efaa1a04199c25d1b3c9d881963bee454ec69c0c890bd5" => :catalina
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
