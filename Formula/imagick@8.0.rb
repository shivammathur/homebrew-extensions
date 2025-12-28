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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "5cd5de114957ba0585e890b6141e9d66ed78be0af56912a1565fa6fdebed3764"
    sha256 cellar: :any,                 arm64_sequoia: "294c0041d36897f1eaac665bf7d3814c1c19b4e8aaac9f152b26dd40b28c71fd"
    sha256 cellar: :any,                 arm64_sonoma:  "e891411f38196e3177b3a8f174652f549565709f9e86c898baebafd8b7bf7b0d"
    sha256 cellar: :any,                 sonoma:        "504336c99f76f38f4cbafbcb86d9c3579cbf89ea101cf5d194f83b7dc5d2da58"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "593b244fc78efc4dc2d6168953eedcab96403f02f17c1af5b1ace6d7c6bf6949"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "181d7aacd83a4177a41f69aa84a6fd53e1209e30ba2a8cba4ccb51ef02defbad"
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
