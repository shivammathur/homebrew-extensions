# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
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
    sha256 arm64_big_sur: "943d5933de821fe151ccd8bcaed41e97e5670fbae2ac78c7e119491558b35d5c"
    sha256 big_sur:       "e16dbd850deb31763bcab7753fa4e250330904cf79e47af5fea43505795d0165"
    sha256 catalina:      "06404d74ea692a05deefcf9cc8c3cfe426c9321d91b66ae9fd47b84cd109a91b"
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
