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
    rebuild 12
    sha256 big_sur:       "84f1ddf6a8685899e0999326685e398bb63e68cb26c8821c1a84f472cf9e43d3"
    sha256 arm64_big_sur: "a51736185028025e5649d83e1234a465ed6ada9432bd2f2a7a60cfcc9113d826"
    sha256 catalina:      "5ee85a4e7526b9c7597810c6e08a02bfc2d1f5edcf7e7a62d356b836adce01c4"
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
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
