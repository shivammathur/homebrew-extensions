# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
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

  conflicts_with "gmagick@7.2",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "ab8dd837d586fe5241fb9c801df9d9c3b9193ac19b1354ce6c983a99d8bdbf98"
    sha256 cellar: :any, arm64_sequoia: "d0cb0762a458b466d2bdd717dea044d6bd06f616637baef978680ea4c9b259de"
    sha256 cellar: :any, arm64_sonoma:  "2aa83eab1425073c1e36643fe450ac3473361e80f1d35f113312b1e0930a1d21"
    sha256 cellar: :any, sonoma:        "635506dccd59e662dd6acce1e12d0e452b9057681a2ca1f26e07d17145702e3c"
    sha256 cellar: :any, arm64_linux:   "50cc9adbbb74bd8ce4c3bc466c64dd25410391b8f501c1a8a15f35c24de6acaa"
    sha256 cellar: :any, x86_64_linux:  "11691f5947a72ec307a52c9191a87fca0fec58bc732628fc40c5f63c66d0fffc"
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
