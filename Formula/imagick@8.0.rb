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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "fe78511c77ba024a7a67318652077385d9f9236dbf84ea383d18fec62d263041"
    sha256 cellar: :any,                 arm64_big_sur:  "f2e98632e772cc243fb041675f271f94c333d448114d6e53416abddb803b55bb"
    sha256 cellar: :any,                 monterey:       "1bf18e9f694094e917bda127efc60d62d414ce658251273e1a6acf17c0f86cad"
    sha256 cellar: :any,                 big_sur:        "80219631b4ac6f2cbb193dcb5965fb9b2d2fdae003139151654d32ea1a71f28f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "24effd78ef6fb26617c2d2fb86271f8c7dff46d47486831e218eaa9dc65c3418"
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
