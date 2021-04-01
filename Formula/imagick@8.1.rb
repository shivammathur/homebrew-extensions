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
    rebuild 9
    sha256 arm64_big_sur: "2e6599317b261ec93040c517af295fc6ca585fe16db30da130415d9535fe7056"
    sha256 big_sur:       "a39291d548e83b3ee38cd6db09f8efa6d7db76407d621c68ac1561e052b80e16"
    sha256 catalina:      "872f158d4f11a976b015264aca70fcff5b9750e96b88f4c128c5dd6334e3fa25"
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
