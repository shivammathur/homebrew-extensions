# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "1dee20e214f24d21897b7a4e56025fe23ccb4502b7d858453216d41580d64d82"
    sha256 cellar: :any,                 arm64_sequoia: "40025cc0fcb70a5300296f43d0df65bffdfa0fcc020bc6867db425cd32a4dc3d"
    sha256 cellar: :any,                 arm64_sonoma:  "856300a1161b0f81e529df4d3a432121be2f0282e0c2ffd909b701126854d16a"
    sha256 cellar: :any,                 sonoma:        "8e951cf71990a8f5288f3d24a8db3c954a76126f362518fde7c4c500528badef"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "70192a2b382901e1df662581956f335c344500707a9c4a2680b1a7ade51c722f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a367a56fbfc58ae444a90bd782dc82c02d20f7b7c2b416f6ca0e6167e6897da8"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
