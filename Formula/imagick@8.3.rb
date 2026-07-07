# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  revision 2
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@8.3",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "eabd4d8bd394d42b9394a03b723e8fd6a740bc797f272ff2258bad9b58762214"
    sha256 cellar: :any, arm64_sequoia: "032322449b9f3d93d1233d44ec92574e0a421c2bdbac02a99d4ef3f965b324df"
    sha256 cellar: :any, arm64_sonoma:  "7c326b711bc969a10167f3c9c349bf6093d64fb0daa3a731b1fec951511ee8cd"
    sha256 cellar: :any, sonoma:        "2a2e5329ba1dbc1548e33be1e12f91c206922b440b3916a19e6e764785d8d572"
    sha256 cellar: :any, arm64_linux:   "9780c8f4c4fee532f8c48777dac152f94bacd16563e89b388c066c6f75f22767"
    sha256 cellar: :any, x86_64_linux:  "805a9ba477bcca5d7baf10959430e73191bf916879692717f2b6dec323cf597c"
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
