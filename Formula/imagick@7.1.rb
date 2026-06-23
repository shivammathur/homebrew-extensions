# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
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

  conflicts_with "gmagick@7.1",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "ace2f72522f3c0142f26595fec04d06d87407a03d1eb689b399522e00b7b4769"
    sha256 cellar: :any, arm64_sequoia: "c2851962b5095922056b2e6f9772faa2a4b39f2c87558d4cacf40c7f7f6051e1"
    sha256 cellar: :any, arm64_sonoma:  "6f7ee3c89f3587814d273b83aae1de4d57909819e3d65d0653122e4f3c8ffcfc"
    sha256 cellar: :any, sonoma:        "87d1d74eacfb1f3dc9ee37aca5547073d453787cf2b9db66a0e36b196a408399"
    sha256 cellar: :any, arm64_linux:   "790b0d5793b8da0fe1b7ebfd1fe9b094418739417580a9547165583a73c7f48a"
    sha256 cellar: :any, x86_64_linux:  "de9a3562783c3feb65ce700be5106cad35082574ab0ae98a4bb9fbc8cd8e0bb9"
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
