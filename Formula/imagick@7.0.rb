# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class ImagickAT70 < AbstractPhp70Extension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/Imagick/imagick/archive/3.4.4.tar.gz"
  sha256 "8204d228ecbe5f744d625c90364808616127471581227415bca18857af981369"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file
  end
end
