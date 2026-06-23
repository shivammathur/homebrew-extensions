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
  revision 1
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@5.6",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "182873db075e806f8e1822ed33ff73f1da4d5b238b81f1a8a21199c16c6e741c"
    sha256 cellar: :any, arm64_sequoia: "8e1b9e5a0fbfd9753c9b5f50010e2b7c4689ce04767299c20c2e71c2d3fdc5ee"
    sha256 cellar: :any, arm64_sonoma:  "5b5c2595e501ab5e6d2222978f2ef56b7130cf04e8124f427688ad048a1e393a"
    sha256 cellar: :any, sonoma:        "7dc48a5008f06a353ce240c6c4e71b4694897c7d2b00f1d970ef06a04f047db0"
    sha256 cellar: :any, arm64_linux:   "4a849bd0a9856ddb4d11d7d2bd00c0629886330b8d57cb424d17a5b682e2ebab"
    sha256 cellar: :any, x86_64_linux:  "cf0286343a3fc501afca3ded8bb3c115de37dee32e35faa3ef27f216b3d37fee"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Utils::Path.formula_opt_prefix("imagemagick")}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
