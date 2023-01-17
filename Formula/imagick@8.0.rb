# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "14dfaf65a088ca70772532df59edce1f9324432ac0a1aa7e1447cc1746c1444c"
    sha256 cellar: :any,                 arm64_big_sur:  "2829b8f4036fac90e94e32b87b5726daf0763b2373c20538e25bd9e84135c076"
    sha256 cellar: :any,                 monterey:       "0a84be64c44cfa21b0c3b6800639521b954138d85d7ec281cc5b4a3fa9788319"
    sha256 cellar: :any,                 big_sur:        "673fa95b7aa305cc853d225e894c6669f68e33110a8ea53b3ab41c38e1ff0b2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fb8a3f7e5db8f3b5a00472826e7abe10907bbcec743257aa43f597dca84cec92"
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
