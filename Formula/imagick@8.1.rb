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
  revision 2
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
    sha256 cellar: :any, arm64_tahoe:   "9712653fb3517d188e5ba3879235ba981dc8a6c22805d9827ff72c35bf0aa981"
    sha256 cellar: :any, arm64_sequoia: "2880ec2382d2440c1ed54abc1d8c85b699134572d88923ce9830c92b3ea1717a"
    sha256 cellar: :any, arm64_sonoma:  "aaf6fb53e4d03a56430dd716d8c670515f7edf3a17123780f2c97a4871f6fed2"
    sha256 cellar: :any, sonoma:        "14a3138c24d9f8056ca406063608cf62945dfd7bf2e131d7ad1a4cd974bc9647"
    sha256 cellar: :any, arm64_linux:   "055cb194527ffcf41bce4498e0298d96eb90c4fc2824eca6d5662d88a351edc6"
    sha256 cellar: :any, x86_64_linux:  "a2c72ddd9d36c55a4e354140d3a86750fb74fbb3dbc6bac53e271560193e8a67"
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
