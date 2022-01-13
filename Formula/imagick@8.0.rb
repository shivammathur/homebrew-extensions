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
    sha256 cellar: :any,                 arm64_big_sur: "a035c61829973aa44c5a22a7899febfbd296cea7fdf7ebea847defb420946000"
    sha256 cellar: :any,                 big_sur:       "ce1843c2b3b1d99c3feb540f9a7cfd881ee46301330f299e96285de736d52f0e"
    sha256 cellar: :any,                 catalina:      "18a973112e10fa63788f8dcbfceaf3d7c836008b86727b388e690f94c02f6f7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a81c850cfec24c448bc487f87ec746a832315dc708f66e304b82ae432d7dbb6"
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
