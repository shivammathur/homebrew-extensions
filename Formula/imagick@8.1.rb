# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhp81Extension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/Imagick/imagick/archive/448c1cd0d58ba2838b9b6dff71c9b7e70a401b90.tar.gz"
  sha256 "b1b32d524d11ffbd530b270f15205c5523ce81efde3c1bee94f4d2730246c867"
  version "3.4.4"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 6
    sha256 arm64_big_sur: "817b1460e57450831d681f03abacb44c829d5ba68e21adefe91283dafdc44258"
    sha256 big_sur:       "cb7aedf47a22567bd84ecdd56d73a593b644873acc0c97f0941bddf7fcdc1c0d"
    sha256 catalina:      "938062b4095067f253086ac73c831df444e4e36d3adda18e06ec20af09063ce0"
  end

  depends_on "imagemagick"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
