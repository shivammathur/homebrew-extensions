# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
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

  conflicts_with "gmagick@8.0",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "78db1b506679d26efbc7f2f32d3b096de4f2e8a2afb5d8c4d3b5d5609191558e"
    sha256 cellar: :any, arm64_sequoia: "9f1bdf8826de4e699db301948611aeb492ff326955559d5b91e2f7c43f290e28"
    sha256 cellar: :any, arm64_sonoma:  "154b8fcfcf7fda69717f268dbe6a3181025e4adb89e7dc16528d2933e8067d4a"
    sha256 cellar: :any, sonoma:        "b39df123434475673ddea0bb8ee113694eaa4c69db767d8696745f0d880f7079"
    sha256 cellar: :any, arm64_linux:   "075cc5fe2e80ba0cc0db68a766be030fcae0efbba460500cef5486e0090133c0"
    sha256 cellar: :any, x86_64_linux:  "7e7578ccb63f30aa16199e9d8bd3db853f631ad3820865494efe6b8d58f5f9d6"
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
