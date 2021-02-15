# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhp70Extension
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
    rebuild 3
    sha256 arm64_big_sur: "caabd84ea25ec20bc1c010b5f11a2a6b1293922aca87a368ba7a2fa0e619c0e7"
    sha256 big_sur:       "f88132f902f2fb33b116fc04c68d2d9699029f31cbecacd3732a6fcbdc142470"
    sha256 catalina:      "6b7ccc6505a36a86aba1479efbe6fb4325ee5a1c8147ef872119190bf963a88b"
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
