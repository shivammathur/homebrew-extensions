# typed: false
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "265f386e394c229a9e467e600beae2e4b3b937da616c8a1ac23d9984b7091558"
    sha256 cellar: :any,                 big_sur:       "9758e7bde63f4edcb03dfe9d1393b0a8db3bb83398603dcbc0273acb65c8ba78"
    sha256 cellar: :any,                 catalina:      "7255ff983639931bcb51a746e35205abb77b6e576fd9447753f73dcc43a532c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "60b8cdbdaf887666f4173bfe144b58bb1458367ea0310e37ba89484c88e345b2"
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
