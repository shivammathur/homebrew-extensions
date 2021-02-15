# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhp73Extension
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
    sha256 arm64_big_sur: "3ce08a18bd27fa3a3ab5c638eac64e15951f18d23c2fa286281ff36ad8d84462"
    sha256 big_sur:       "a64cc84b36972193f1c36f0f2ed4e4235c05ca51c18ca25f54cd29122c831ff1"
    sha256 catalina:      "6b641a2074d7c1bd98e92d5b4e9bb86511b399a881376935485b2ecbff42a469"
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
