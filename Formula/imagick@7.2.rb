# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhp72Extension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/Imagick/imagick/archive/448c1cd0d58ba2838b9b6dff71c9b7e70a401b90.tar.gz?init=true"
  sha256 "b1b32d524d11ffbd530b270f15205c5523ce81efde3c1bee94f4d2730246c867"
  version "3.4.4"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "b362664a20cdf24a41b56b9f72622acd2c3dbddaaafea134410300fa42c11c37"
    sha256 big_sur:       "5b2e2ef109a93a980030c3d44ca02401be693570b8aa79d6e137432ebcff5f8e"
    sha256 catalina:      "c44448ee067f6ec4cadbc30d6e0ccb35514e4675c38dc6b8d078596029d1e91a"
  end

  depends_on "imagemagick"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
