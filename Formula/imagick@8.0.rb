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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "3cd47166bcbff0fad913825406c26e57912b286d240db96620087daaa52a26ca"
    sha256 cellar: :any,                 arm64_big_sur:  "2f74b96cc7a6f17d0195262fffd69cff8e75f931350179142be9e3e2f9db5a12"
    sha256 cellar: :any,                 monterey:       "b7ccc1443ee86e3591a9be4e0383d52025dadd34e5996053eeb0282e4afae986"
    sha256 cellar: :any,                 big_sur:        "361891a867de4c5cd3b3d8b6ff44537efbf8ef991abc41ca518391224853855d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5c8d6fb2db184a9ab90266f21747e12aaa367a9fc64d2962aa715fd99ff7a68b"
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
