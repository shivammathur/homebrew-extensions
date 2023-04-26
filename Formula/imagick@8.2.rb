# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "19ea6bbd8848543b02d8ce74b8ff8cc22333de5d8104f905e0bd5044ab5ba4a2"
    sha256 cellar: :any,                 arm64_big_sur:  "810dfb06a156760406db42a086e0b3d14b44e9d4aafac16c9aba824cba91d805"
    sha256 cellar: :any,                 ventura:        "ff77df0f8e50461e19124391c28b19fa1eae2547d0820f5ed70b6f653d9e48df"
    sha256 cellar: :any,                 monterey:       "65db9fd759286972af425e81414c778f915b498e124c9aebc111c9f910b3db10"
    sha256 cellar: :any,                 big_sur:        "92e1cae7650b2ce3c0628e5d183a95b511994280b92c90979f36f7ebb69634b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "14d08cb2fffc33e75db6c4ef9619ea020080c45f92a347302cf6e11e1ea8d6c5"
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
