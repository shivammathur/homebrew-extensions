# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "50d754561a716597ea2e51b25d23bd2c1756cb4fa1a041c7b8a9689e23d61c2f"
    sha256 cellar: :any,                 arm64_big_sur:  "57873ebac830835256dd6ae4957e361f37a9ca7b1c90e965fa62918746a2f496"
    sha256 cellar: :any,                 monterey:       "7eb3fd6731220b0654b28122d94e6ca5cd5048e05bf6405b06988ed5e64071c7"
    sha256 cellar: :any,                 big_sur:        "3fef4a68ea6b18eaa402b228024ead2b35090300f55e775c6407f9e310abfc51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38a74c88724d23dd9be0126669580b5afbc2b200756350e9d96131020dd92da7"
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
