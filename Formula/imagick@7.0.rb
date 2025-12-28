# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
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

  conflicts_with "gmagick@7.0",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "062b506ea217125cad35f9ec0887490b285386dca9a0a4c2b0b13d80eddc0011"
    sha256 cellar: :any,                 arm64_sequoia: "80c87fb7f27531e162567a038f6ee8ca2371947482f184901b9dfefa749e09bc"
    sha256 cellar: :any,                 arm64_sonoma:  "6e83101d8623f2845f4755411660e8dbaf0c461f1128471e75aadbfc0ce72090"
    sha256 cellar: :any,                 sonoma:        "48ea2a5f905a8b8b10b85c5a367cd94cd8065ac7520713688cde15ff646d9aaa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3dea37a44c8c076b6a09e35c49307986812b4d9981ab4a117a820cccf6086f79"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eff128901b2c448edaaa47b0b5b5a0481b6242501c61e600b83dc43207c50c94"
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
