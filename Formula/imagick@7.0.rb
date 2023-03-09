# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "3d975f3ab1c1d37053cc13b08eeaa5adedc22038081fa099a6b5ec353c9301ec"
    sha256 cellar: :any,                 arm64_big_sur:  "9f356331b8c7eb0f455220866956b2cbec59e9ff47d090c1ca59186d1c46066b"
    sha256 cellar: :any,                 monterey:       "47e921bca2d767347f1069ece8ef81fbb6702764a7a2e7b763468800bc9baa04"
    sha256 cellar: :any,                 big_sur:        "60a64c5aaab8f65acde6c78b5f855adfe8297f366873ab6fc54d61c811b6443a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "afe0243924d356a6a327590962ea4cc5f4a5a446bc46b81d43e94c6786f378ef"
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
