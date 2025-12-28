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
    sha256 cellar: :any,                 arm64_tahoe:   "be4e29a223308e7f11d864946d25b16e7aa2fa7527b4797e2b04327f7d97db1e"
    sha256 cellar: :any,                 arm64_sequoia: "85f66613a855e0933a5c2f4eb8be3094146ccf0b50e468de0d298ed0ceb74e27"
    sha256 cellar: :any,                 arm64_sonoma:  "286718e6502442bc7fe2c8811b1ce279a0be33f495f565012e9df1c5f47123f6"
    sha256 cellar: :any,                 sonoma:        "95bec15022cf7ccdd7eb27df575d976bf5eb40a2f8ad91236f20173236f0ace3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3331deb0ae141d791fe22b11342a96ba23d29af40f12a8a13f6d48a34be1cf24"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "771f8a563e525466818f4e6d877471f30fb0e1387b8c7a6acd76895d23baf2c7"
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
