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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 arm64_big_sur: "7c293bb37c8d645b607e9f25f54e13ef7207625e542da6ce441fdd25c5ed1f0e"
    sha256 big_sur:       "d123a90f953ed8f17690c9c8b1bf6540db20120c2d4593f846904ebf7be46a18"
    sha256 catalina:      "3bf99c0fbd400105616fa33b69dfaf9579cd0bac24fac3280739bbdde2c3dfff"
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
