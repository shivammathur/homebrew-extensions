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
    sha256 cellar: :any,                 arm64_tahoe:   "8af59fc6a696aadd0a27d09a828b02c58927d747932e8baf38aba4d84adc4ca1"
    sha256 cellar: :any,                 arm64_sequoia: "c0c71aa7d10e2a5fed816c0a43859e921aa800b728eeb84d08f891e447ebd556"
    sha256 cellar: :any,                 arm64_sonoma:  "127a75abb1d6abf05a7c045360da5ada4a879129b87ff0bc09dc7c0985063371"
    sha256 cellar: :any,                 sonoma:        "29ccdc4db893b5a7c4903e8e45e52ada004fc186f9bc23dc1bbcdbe474e8b5ca"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a95dc7dce946a3f8eb3ab6b161dc57021fbdb44888ae5eee97f9ead2f1854958"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de12b2f1146c6adf1daede468b4decd37d33fa9f110722c6864292d211c02f1e"
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
