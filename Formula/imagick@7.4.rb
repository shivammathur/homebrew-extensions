# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  revision 1
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "d20d4e8b7c6f3043fbf71e87710092382ef25428173b9d8dfb918c335be2f895"
    sha256 cellar: :any,                 arm64_sonoma:  "8a7780fee113d9def729c1880c105358ef4310af852ea929191f2b51d5a4ea37"
    sha256 cellar: :any,                 arm64_ventura: "8d54a5a3425c502ddced1a2fa66270855344700b20e90f1efd53fac762345dd1"
    sha256 cellar: :any,                 ventura:       "2be67cc554dfde8fc7fb9c055175bfae661489a5f73d3cd56f43237534ec5d3c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "60d53e4017ed0c1f0b4f267b174823ea5ed8ebdbd4c56499eee3d3f38226d6e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "85c58de41b88fe48dddf37f25ac191e6e3af160e72593867b6187645b56447ca"
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
