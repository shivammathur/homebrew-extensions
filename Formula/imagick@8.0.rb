# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "d23be4d2170c0a4263b183c097618164751b8324a7b09765b685d8d89617d257"
    sha256                               big_sur:       "ccae9be050cd14fc8432d51b1a020596b389f15579f2e60c1d1d00e9dc46c919"
    sha256                               catalina:      "b3bd767260cd7bcbd1842625fd7d22b95382bb656c6dfd4be12a6aadbd73d707"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58279b974955cae2c463fa0c18637e45fb3cc121c52b4c565755e589ec3cf45e"
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
