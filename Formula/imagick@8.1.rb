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
    rebuild 3
    sha256 arm64_big_sur: "3bd2ac94c32bbfc8d9a77007a95e39f2d6a4ee15e62fcc6266b33953978a10bb"
    sha256 big_sur:       "27617710b359d33a893ecec89c7e7b54ea77db2917b57da3177c51bc563b405c"
    sha256 catalina:      "123f91524f7f87883af3799bc00a643eec58749d83250406ee05fa3e8f06322c"
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
