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
  revision 2
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
    sha256 cellar: :any, arm64_tahoe:   "c69fbc9af52223b734f664f5c6ec5379efe13a029edb2952a71747161082a0e1"
    sha256 cellar: :any, arm64_sequoia: "2204b04a2b3424eaec7437de72e9b0a9861289fc347e3c3ed9b5b083ba758800"
    sha256 cellar: :any, arm64_sonoma:  "24e990d41708f28b913fc62453f454d60c2b848f3a87679e89a07f0249473db1"
    sha256 cellar: :any, sonoma:        "bc258d294f2b1ee7958ff692f2f2360c718e4719cc7565a19919c54bde4f457e"
    sha256 cellar: :any, arm64_linux:   "d5062a494021cce4e52d0c7a5598c156e525c2171828177b110d300e7456aaca"
    sha256 cellar: :any, x86_64_linux:  "9bc85f7d494bb3cb2a04598e08042fd1f194b1629b4c7c5a635cdd47494170b6"
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
