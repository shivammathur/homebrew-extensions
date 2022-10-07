# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "1d45b14c6aacb58be9850ec265897ea8781801c433a467e96871fb598a203e35"
    sha256 cellar: :any,                 arm64_big_sur:  "ccb9dcf72b339cc4f5555efc923fb456c3833ca305d4c00f45c6b24b0927b52e"
    sha256 cellar: :any,                 monterey:       "175661554c8a696672c5f64df68f01a35acc9fb255a306aa44c70dbbb3f31d2c"
    sha256 cellar: :any,                 big_sur:        "21924d0fb11704a82c902ca726e99afee902ddad3c591162aa46e3f5f25bda52"
    sha256 cellar: :any,                 catalina:       "f0eb4c4a91e9a2d278515e1bd864bf08b91fb61ff8dc381cf9e35d4387860cb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8ede5486b65e450c13810e04a0bbf3a2236eb2ba512e014512b8530c02098941"
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
