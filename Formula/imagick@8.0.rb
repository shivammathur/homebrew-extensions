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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "509d31c19588d66fb24d0f79a253c7a94e3d75f58b42c2e43b23262659d21f3c"
    sha256 cellar: :any,                 arm64_big_sur:  "4fc31a687a005d382c7415e54c14b4aa05efd74bdada0102f1dad2108cac2207"
    sha256 cellar: :any,                 monterey:       "bd361c0d595fafc1b74624dc3325c679a35dc2eb079c9899d08a149d073a8bd4"
    sha256 cellar: :any,                 big_sur:        "d87dbef2a0369d3111a58cc36b2536db5ad37f0c7c43a807ef8d33529a17f6bc"
    sha256 cellar: :any,                 catalina:       "7776a8d40bfe8b691a52474cf2b05977ff383561a3d74489caf00e8ea38f8439"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a546f2dbadfde3bbaf93301ec2b218d7b7b6cb99e3d464741cc850721b074293"
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
