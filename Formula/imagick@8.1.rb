# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhp81Extension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/Imagick/imagick/archive/132a11fd26675db9eb9f0e9a3e2887c161875206.tar.gz"
  version "3.5.0"
  sha256 "f94982135603811cd15da19b80959c7456ada9a916af5bd7162b5bad80fa34c4"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "6375ae12f70868e8fff75b09cfd676c2a5570e776ef1198f83d260e670194871" => :catalina
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
