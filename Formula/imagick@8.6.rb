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
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "56608ad89dd90071f4d9124fe43909eae7b66ddf71c8a96719f58e39e1e3f09f"
    sha256 cellar: :any,                 arm64_sequoia: "f3477ee65d6eddccfe31795640aa924c4c92b72c8add325561237cbef1c1eb7b"
    sha256 cellar: :any,                 arm64_sonoma:  "934e00c498415fcc965fca5352b85ca24a9eb4edcbcde3a4bc204279528e2d5a"
    sha256 cellar: :any,                 sonoma:        "b5115cc7926387ba5814353ae09e0b7d6d4332c6b93ff6c3bf60b7a637898189"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6996c267ccfa245c0fd399bba83c5dd8f1b0f1dc02705cda67ac889bbbacf9dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "51c79c5e693e3a8cda0b9a55fecac0139b880724961e6ce505bffa997d46dd6a"
  end

  depends_on "freetype"
  depends_on "imagemagick"
  depends_on "libomp"
  depends_on "libtool"
  depends_on "little-cms2"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    Dir.chdir "imagick-#{version}"
    inreplace "imagick.c", "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    inreplace "imagick.c", "zend_exception_get_default(TSRMLS_C)", "zend_ce_exception"
    inreplace %w[imagick.c imagick_helpers.c], "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace %w[imagick.c php_imagick_defs.h], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
