# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "808f5575389a73f28da0ab3a544fcc374918a74cab5ea1988cb11fbf64762e7d"
    sha256 cellar: :any,                 arm64_sequoia: "ec74b8b163879aa36e13e3f1f728ca795565e548b33f221059342afea3333827"
    sha256 cellar: :any,                 arm64_sonoma:  "f8f7887bf26ca535fedadd64d0c00f3f36df79c61018f7d377f2d1824daff968"
    sha256 cellar: :any,                 sonoma:        "de9078aec9a21cecf96182c849773beb511d07ea8b0022f42b0e33b848ccd52d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0d3e942e6757fc6a68dfdeba0956d9165f22eccb7df03384c9bc51ca9b21aa04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e21f7af24543a854901afbb92f27f08d8ff09bed7741bfd6b612e2d088e814f2"
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
