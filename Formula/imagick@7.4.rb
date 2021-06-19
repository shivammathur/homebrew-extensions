# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.5.0.tar.gz"
  sha256 "f32fb86fefb8531fc32768b9732305f8ada14f249cf3b74c9aaa664c6ae38c27"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "6f1a9c089813cdc2a2d1cf3d8e39afa3efbd79f65cf504cdf224feee07a50038"
    sha256 big_sur:       "dd795577c55669254a8b3f23c0eb2ad5a72be813b3f17920c7d86b3d5d12fb64"
    sha256 catalina:      "e5464a91b37a0f9218c1611dac45f4123f6e591b85984e0f2aececf4b5faae01"
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
