# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "5e1403b1b6b2e6c146a6e1853b04925c4bb016bcd62c25c3d7935ddc74f8c698"
    sha256 cellar: :any,                 arm64_ventura:  "af1ca84803d1fe3328457e56b3dcd4223fa2b4e65560c13c33577ecc131fb409"
    sha256 cellar: :any,                 arm64_monterey: "5f0997735d9f148f5a52a411adbe5dcb7f9652744b856fb56464417e10ddde59"
    sha256 cellar: :any,                 arm64_big_sur:  "fbe067e957d0a383feef407d22d0441166d5bc92021b4f8b533ddbfe72b49fff"
    sha256 cellar: :any,                 ventura:        "709692d202507feb25d18df29ed91483d0e221386607cbb34a374ea16eadd4d1"
    sha256 cellar: :any,                 monterey:       "64807dda2eb4ae1bdb66fae1d3092b32cc1376c493a485c7321e68dc0a306995"
    sha256 cellar: :any,                 big_sur:        "e6b0b1de1d936fcc90cac12a0835d415c971b7203def04b99d11611b7e97f10a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "602420cb046f8455db2614802f245d5561e60862c35c9ab5550879a7331cf1c4"
  end

  depends_on "imagemagick"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
