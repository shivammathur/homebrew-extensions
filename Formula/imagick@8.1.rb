# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.5.0.tar.gz"
  sha256 "f32fb86fefb8531fc32768b9732305f8ada14f249cf3b74c9aaa664c6ae38c27"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "5a63fd102c9628360f66b81aa5d02595013ab3389dd513fd8db548fc07b19284"
    sha256 big_sur:       "05aa08afb8ea885752154324d3f18e6648435e42ec84070bfcf17d27e6d88b4a"
    sha256 catalina:      "d3de39f40cdf13cf9e83bae207c52a4097d6827a995cd104b63e25ffefc39b9e"
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
