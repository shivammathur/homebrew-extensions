# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.5.0.tar.gz"
  sha256 "f32fb86fefb8531fc32768b9732305f8ada14f249cf3b74c9aaa664c6ae38c27"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "3e809ba7027f372b8d38e5a65e2ddc1b76c5b2d8903897432d909dac3e1fc353"
    sha256 big_sur:       "535608ad6fdffbb0fcc06c1c12fc6f369784ee5ceffedeadea54acb7c7200f9d"
    sha256 catalina:      "f7215c6d9a5089bead45e1ef0c7e8fbcf56c598c06cff6df6400cbfccba7c3f2"
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
