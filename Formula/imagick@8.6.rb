# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT86 < AbstractPhpExtension
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

  conflicts_with "gmagick@8.6",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "90a928542e0b38f299db2fd8c45897e3956499d625510d8f6d5e4c4636170dda"
    sha256 cellar: :any,                 arm64_sequoia: "aadb1153c483163319258199ac0e4c4effd0121981c8076d69c063e8d25a70c6"
    sha256 cellar: :any,                 arm64_sonoma:  "10163d9a504e67740e9be1eef129e4836d47812a34e2f4adcb51f7d7ff577309"
    sha256 cellar: :any,                 sonoma:        "0105eb7f7ff0e529c0889944cb1cdddb632358c3ba0312aac5bde34e8c7cca37"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dfeeee56d0a154fbd926d8b55fd7ffda130e8c1007df8e2595c1f2747a1f9c44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d4d1a52c11f0aeb32038d17a7cae52ffbc64969fdfd6f103ca1576d6e753e380"
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
