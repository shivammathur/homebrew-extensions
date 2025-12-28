# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
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

  conflicts_with "gmagick@7.4",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "3fff42d7bb3b2db796f1cb1c9ff85c0b751f9dd91fbf18a012d6c83cef53411e"
    sha256 cellar: :any,                 arm64_sequoia: "f27f0c52f88e560dd128fbd3e47b35f00cfd26592efa6b234e4d8afec2625470"
    sha256 cellar: :any,                 arm64_sonoma:  "9e568176497ed56eb0b205c09787a0f8037d4fd085a4603a716c5a2d10d61ae5"
    sha256 cellar: :any,                 sonoma:        "f103090a022d85938fb08c1839cc744850c601bd3cd63c1b36c8997c86a97f2f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7163f0881ffc46fa666a6b1c39cf64fc32f5803d35b54bf14e4529a18f7da4a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c22fc96758cfdc4b5f9cf53b497a4ae95aa4415705190eeb64a6aef375a621d"
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
