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
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/imagick@8.1-3.7.0"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "edd44d6e7b91e005821c5ffdb8a680470bf37e89e178d5c29dabe6054e5ef2fe"
    sha256 cellar: :any,                 arm64_big_sur:  "db77c4b474f5332d4836d3f7b0d82424a6f0aa04c959ef5997449f9f0a62b2d3"
    sha256 cellar: :any,                 monterey:       "3068135cf1a1ef4bb128daed59c8960a7b0f1e80b1d5cba1629013fd96d8cd2b"
    sha256 cellar: :any,                 big_sur:        "19ba6c1582a60d9e94ec62af2ebedadabda2b99a298fedc94c07c9d8226849d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "527111639124e7a7eb50429973dd620b6f4d7f779deb68b4dfdcefcc732bad16"
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
