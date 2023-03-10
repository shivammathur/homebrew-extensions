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
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "b4c377f2ac856eefd32ea2bf2589ffe934fc12a6312587f599562d8d14a8400f"
    sha256 cellar: :any,                 arm64_big_sur:  "d37b6ba090119377bcebd3d02f4ae2d7ae41166a160094487205decf859b3e5b"
    sha256 cellar: :any,                 monterey:       "aa64260d1867930d75a492ffef018e3821d23efd0e5b819e563333ca3d8a36b9"
    sha256 cellar: :any,                 big_sur:        "3d7ef8bb0939ffa9f7442ebef43a167f1d42c016190e3a1c0766184b0f783279"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4e74fb34b8414ff945fae160e587ff3fab0d63184c705347c326250330d3d390"
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
