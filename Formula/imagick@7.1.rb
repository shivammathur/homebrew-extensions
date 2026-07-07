# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
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

  conflicts_with "gmagick@7.1",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "acd6bea7ebf9dd2c053f75656e109f0c9e1459fe4654cdefdf88c890ac02fc79"
    sha256 cellar: :any, arm64_sequoia: "87027516ea46adfd68cbe0418372d889eb8f0a4387e5fc57a30f2ca2cdf9e2b3"
    sha256 cellar: :any, arm64_sonoma:  "62e6a68488d7338789b96e63da1b5c78b5e52592fab6bf35d1b537eb3f86c91c"
    sha256 cellar: :any, sonoma:        "37e7e2040490c1b2b4242b0505a8880cf94d19f5b984384b197c16f028026b8e"
    sha256 cellar: :any, arm64_linux:   "cc461defd0a3a91d4c4891a5f88cc64818cf7242cdd25006f8c0f835e767e921"
    sha256 cellar: :any, x86_64_linux:  "07659b2886898a2dd3d6e0f8994a2c125b299cad7a827eadc655b2f2874fd5e7"
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
