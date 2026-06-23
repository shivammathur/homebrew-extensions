# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
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

  conflicts_with "gmagick@8.2",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "d78f866d4dd14588765166e8729d5b694792fb2373a82b30a71c8b357496a12e"
    sha256 cellar: :any, arm64_sequoia: "c5816cfc64e181e117a8b9b06e82635cc4c860cde66192a1ed304e0e21b8c40a"
    sha256 cellar: :any, arm64_sonoma:  "657498338c9d2de73fdf2a9188d17c884beec13f2c32fd2840ce4fcac07c8aca"
    sha256 cellar: :any, sonoma:        "85e9a98d4c82031d355a30b0b52b943e4c0ace5e3837117710c75811b2ef7736"
    sha256 cellar: :any, arm64_linux:   "8ce3bf203633303eff7c5508ba8bde5d83db93093598905a59d16837db130cea"
    sha256 cellar: :any, x86_64_linux:  "50d4ba4a37c5492f45b5f979dca4ea7bb14351ba45f5ef1fe55f7e158856277f"
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
