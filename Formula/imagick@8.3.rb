# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "fed01bd1f4b8e22ebe0b6899b0a024d512d9786081ef41a4e4450632fddd271c"
    sha256 cellar: :any,                 arm64_big_sur:  "54bbedda3acf60be284eec1982cdcbe2a01d7abc8d1f2c8109220ab6c73e284e"
    sha256 cellar: :any,                 monterey:       "22acf4198fb050e5077448bedf6ef55d5936a14813d2c04d62bf10dbfdf0158d"
    sha256 cellar: :any,                 big_sur:        "b2f904ec1e5a52e38c55d7e931789f8fadf10f402b5c014b13059afe24f5b28e"
    sha256 cellar: :any,                 catalina:       "f3cf5321f95b1aec74bd7dfcd22571bed8ab0456f1af26426ec3114e3f9f5f2a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1aff98517a7677a6748ef82ee75f6a28d2c29e95f2aeb7a1db7c8534a584b802"
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
