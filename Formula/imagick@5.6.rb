# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.5.0.tgz"
  sha256 "795db7c36fbacd3d33a4f53ff2d38584c846e80a04dcd04c55e9e46c28f5d229"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "3aea07c75f5f142c3f7ac67584b560dd82f5fe8ad799af9edaab0f4cea51bda5"
    sha256 big_sur:       "52d0aa2fb5d09eebb251db0cc665356eee958e04c0437be63cb4afffa8e1cb40"
    sha256 catalina:      "ccb5ba54612aaf9cc461f5ae253a78fa9a226b35b4f8afce4f9aa3d23b525a5d"
  end

  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
