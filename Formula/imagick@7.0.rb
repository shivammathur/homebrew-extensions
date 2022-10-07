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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "93d42e487a4fffd81bdc7917d77015aa3eccef7477255a4e86fbd88584cec3f4"
    sha256 cellar: :any,                 arm64_big_sur:  "cf7c892271624adc4b2891f0515bd0ca27186d4ad29537ee361b53cafd6d995c"
    sha256 cellar: :any,                 monterey:       "d5190ffadf9ef50f61a52b609290317ee9f611d49998df3c372ca7aefd89064d"
    sha256 cellar: :any,                 big_sur:        "fb7dc8f85a0111eaee7a2236c128f771c0773388aedeed9544674ed2df4547f9"
    sha256 cellar: :any,                 catalina:       "8a7bd03f13676523486f7b47458abe96860698fef21df34fc02207caa376b396"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4cecadecd45066e7815bab0ce50e501b636184a7d5780fa18a4de085b1bf18df"
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
