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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "2fc383b787302e482217b86756fe49de242f4296c528797d7c84649bca8bbdb3"
    sha256 cellar: :any,                 arm64_sequoia: "36bafe7b605aa32e01316058b1c8b247ec20cd300458f2bcb7e8b1edeb0e9c68"
    sha256 cellar: :any,                 arm64_sonoma:  "2af9bc976be3aa20b5afc209000a26e37400fb8150eec9c637005375a4636bf2"
    sha256 cellar: :any,                 sonoma:        "04ee73f2b60220a3c1cd606621d61833fdd87b2cfc66f7badb5cfc0a3c141e55"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a745d8926d2dcb35a1b21630bfbaafcc28e0d0194ce247e6185711180235de15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "74c141143015dc469b4cb32e142f4d59dd84cba6ddef9402e65331a9efc972d1"
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
