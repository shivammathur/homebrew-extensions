# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
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

  conflicts_with "gmagick@7.4",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "877d8c1abc128a552a2b1999da3081433ce9594d9bedbfe2578ea36bafe490db"
    sha256 cellar: :any, arm64_sequoia: "0ab7078e0dfc6c4fd7e8b6c712bd8e1a46b9d27c860ec087c2c73154f6e0b9c1"
    sha256 cellar: :any, arm64_sonoma:  "5eea77e34719e32ffccb0f1ed760eff321c1fedbb2468168825a68d05226d267"
    sha256 cellar: :any, sonoma:        "561c8ee80346f952195d3fe616011bfc27da83263ee418bd2ca87ed576cc4977"
    sha256 cellar: :any, arm64_linux:   "d2b7917f6af4e4b77d044b5681c34801a53bceaccf23870bf2634a65d950a5e8"
    sha256 cellar: :any, x86_64_linux:  "bad29dcd1927ff96ef579565d6297d37587ffa4917a4efa5323c50451eadfe92"
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
