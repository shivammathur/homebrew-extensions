# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "12d3bd78284742ce33b291cee57c3a8964082518d33b430a6e8b2a2279832f25"
    sha256 cellar: :any,                 arm64_big_sur:  "4c33d9ba9357a4d612255892949573dcc33abc1c8b32d22d2fd973cc2e3c3185"
    sha256 cellar: :any,                 monterey:       "a4d259847307cae388ba8f4eff3730d2f5aa588cd163dfca3c1a93e4403684e0"
    sha256 cellar: :any,                 big_sur:        "3c77e4aa4616df081b45e70f69d2ab6cbd692f6f1395bca23140d22b01103a30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50109a02c06e6f7515418d8c46d27a13451d7717b832bdfbae0946eec5163695"
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
