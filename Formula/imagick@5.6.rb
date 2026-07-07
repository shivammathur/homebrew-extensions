# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
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

  conflicts_with "gmagick@5.6",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "de54efe04e2f944ca6b5f646e9846d8c5ec28a9100feeb1bbf3a538ef95fdf85"
    sha256 cellar: :any, arm64_sequoia: "39cbee07314824de76b46bf005f4618f5a645e8fefbd6bd1d9df3a6a34df17cc"
    sha256 cellar: :any, arm64_sonoma:  "e8b87ed7041c5d9bc70f73abfcac1ac59005c385d266341848b9a1be4c7b5678"
    sha256 cellar: :any, sonoma:        "37d5f65f59604156b64c8631135b99497bc8374bf03b9cab1b27e7102895fdd7"
    sha256 cellar: :any, arm64_linux:   "3027327f62b330243a8942d00b598bb75c62f25565d843a70e6c28cec933b48a"
    sha256 cellar: :any, x86_64_linux:  "5de4b0622ec18a947b7b50df59bd6de1dabfb4502df3fc213d72ad13c88f0126"
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
