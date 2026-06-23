# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
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

  conflicts_with "gmagick@8.1",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "af88350e8d0a7de062bbeaaf8ea3cd9cfb1825070f5bbfe7a861a0ba0033f1ca"
    sha256 cellar: :any, arm64_sequoia: "ccbf1423838ab8dd9271969414df434d534f7d2e2414aa9b0ce649c9b43cbe90"
    sha256 cellar: :any, arm64_sonoma:  "00f9afd2ae5af2e3b07100e102c84e87b8473dcdfac9c0aa253d5607a07681cc"
    sha256 cellar: :any, sonoma:        "3e4a082beaa1b6de1d274b359b3bcecb53b0a947f22812656515c9d80c7d3917"
    sha256 cellar: :any, arm64_linux:   "65f34745000b54e1a38d5cd199260db21d686947c66c5bb07f9bff11cfd2ba74"
    sha256 cellar: :any, x86_64_linux:  "56ed1b983920a8aa3fca0967e9d370d335fb2cf0644737306534e908c3e96817"
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
