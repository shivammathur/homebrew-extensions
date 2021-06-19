# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.5.0.tar.gz"
  sha256 "f32fb86fefb8531fc32768b9732305f8ada14f249cf3b74c9aaa664c6ae38c27"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "761d6b350a433db7e41655d1d868371b5b1362330b24c499b4f915fa50013446"
    sha256 big_sur:       "8f9d88530982acb29df085812dcb6769bed65920ee82f71f06bb5f28dd125c0d"
    sha256 catalina:      "b905a69d245144f3ba9a187ec5d7354e642556f214013277fc859023a2f4ce41"
  end

  depends_on "imagemagick"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
