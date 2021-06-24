# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
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
    sha256 arm64_big_sur: "fd145f44ac8236e8c4643e290f083e44e9aad66cffdde211f63758fb14af5894"
    sha256 big_sur:       "5d7b0b46d49d6f833ee1cd3e2539a6ac314fe3b8bb5e6dc011c7a1bd3d5f5c5d"
    sha256 catalina:      "f24ed24f17f2e5f9b838011ffbc36f25f7b32a223015fe8978ba50c2627d1577"
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
