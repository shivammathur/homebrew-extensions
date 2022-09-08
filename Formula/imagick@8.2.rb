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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "82c2a9aa733012b030d51d7f8235ffe6525998dca634eb0cda0ff492e06d7a1d"
    sha256 cellar: :any,                 arm64_big_sur:  "d900bf1201bbcca18b219cf3cf023d56d7862500f17a3a2dd88708a0dfad643e"
    sha256 cellar: :any,                 monterey:       "e9c71085b4467f04ef94473c71c367499e5a28271cc6948abdba00e53fa8336d"
    sha256 cellar: :any,                 big_sur:        "bb52baa5799ec72d7f45254d38b82700c4612429be05d47d1033fbcf4e3e7fec"
    sha256 cellar: :any,                 catalina:       "9378019340a3dad0c48acf18636d07114e93197d8984db8e7de7f70762298bbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d75e1ce9b148f041b90f84402d4dd6eb768b83fd798bdbf2113372fbed913352"
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
