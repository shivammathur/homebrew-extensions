# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT85 < AbstractPhpExtension
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

  conflicts_with "gmagick@8.5",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "743273d538986eee8455637c7ddd2aa168bb97bfde63522df5abb1345beb6ef4"
    sha256 cellar: :any,                 arm64_sequoia: "779a6f877e571eaa0ea23811f7bb57cf2ed3ac3a560650637f90e38d88ee79bb"
    sha256 cellar: :any,                 arm64_sonoma:  "2bc3c4bdca452313f6ae365288f3ea396f36b4894757c6063c6c869779c5246c"
    sha256 cellar: :any,                 sonoma:        "475d9d05c24386f1d2563a2c72227000604ffa7686dfdc149cc5cbac1243d5e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e180ab364adf14b25f57a432aa4a4ca7655321a73f523584266e6be466d57dcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b552abd378fdb9c3df761f2fa8c0194cba6fa67ecd41cb4440f43b68bea3c80e"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    Dir.chdir "imagick-#{version}"
    inreplace "imagick.c", "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
