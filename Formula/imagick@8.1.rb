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
    rebuild 8
    sha256 arm64_big_sur: "8b619277604ed4961a9e8dadb56fb7d5934de869cebb8be79bb930e36a47743f"
    sha256 big_sur:       "99a274e9060b6a84a753e631adf56fb2b944ae309f654a3b2009613b33a3e27e"
    sha256 catalina:      "d8b6e61ca9bb59bd8adf2f78aa925edd824e1ce7ffb1d318cbebba6566d47824"
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
