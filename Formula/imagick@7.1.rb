# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "909fd8ab6c9d798bc3b0f26c9d6cde95de0d38b76f2d4127afbebb4ddcea716f"
    sha256 cellar: :any,                 arm64_big_sur:  "970950aa9a56ba0987d566ea5fcdcdfadfd1454be4c3b67b6f76a03c10c7a4f4"
    sha256 cellar: :any,                 monterey:       "d42a4a5f5740f15d1222a65a34257d233058cf0ab25b7cae67fb8fda8001af34"
    sha256 cellar: :any,                 big_sur:        "dd3bb581716f27f0c2c4f1264ec6d4decf1518b7351cc29e2f71b9cad61d524b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d7ce5677dc41de0f64d92aa8109cbfe1d46aaf6900a747da91665e2dc24a1947"
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
