# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhp74Extension
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
    sha256 arm64_big_sur: "850351b9c0854d747b8c9d60beaa13e2a4ea5b4d07953b40e0ff98d8ca766e46"
    sha256 big_sur:       "b18b96514c8d1c28957774f02b650e7aea05deaf126b42ccff1da64a1bd6f432"
    sha256 catalina:      "9f84b3273d5826a1d5afc52242aece9c7e6d58f36959cc16d19369d4c7a5f64c"
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
