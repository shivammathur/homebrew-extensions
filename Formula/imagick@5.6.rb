# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhp56Extension
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
    sha256 "dea48b750d9dd6e6555bfc9fde8abdd42753ec829ef803fb15589bfd75772167" => :big_sur
    sha256 "8ad049060f7b380bc24db0c658de7bc992e01cd47d98bc74ce86ce3f530b263d" => :arm64_big_sur
    sha256 "07d64ab4eb86613ebfe0fe1cc71f5e5846eab20f0241ba78aa6f344d91c9a664" => :catalina
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
