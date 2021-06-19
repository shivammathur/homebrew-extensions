# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.4.4.tar.gz"
  sha256 "8204d228ecbe5f744d625c90364808616127471581227415bca18857af981369"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "6ff233cee012592452ce3d7e8abbfb472f4b2d724f39a571111cdfbc607a00ae"
    sha256 big_sur:       "1db98a0d08b5ce9de9af4d2e46d109a1747209449f12731e26be58a3cb1c6af8"
    sha256 catalina:      "1bddc87c9c3d6edb5eca8ddc3ab6f3aa74d5c74d0334a339c3d819b3c8bb07d6"
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
