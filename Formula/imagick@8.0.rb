# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
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
    sha256 arm64_big_sur: "948069ab5bf178205e5dbed19551c47f396c13e91d4a736efc7aa753ff9e1b8a"
    sha256 big_sur:       "cf8aff533a6b24bb7ca0644d56ee652bb9f82772aff56f0944230091b9456320"
    sha256 catalina:      "8c2fadb8a890a167a309eab39f31782f8263c6cd6ad324da7dca53f0eacbbd69"
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
