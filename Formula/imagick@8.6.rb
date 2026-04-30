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
    rebuild 3
    sha256 cellar: :any,                 arm64_tahoe:   "40ad3efa23526dbb662897cff9a4a7eb7947e22a1cd3afdc23d7595e55ec3af4"
    sha256 cellar: :any,                 arm64_sequoia: "8f6ab2b384667a303935cf5510a0ba016e884b7fc092ed22d82c7624f0c7a776"
    sha256 cellar: :any,                 arm64_sonoma:  "dfdcfa67258b29236cc89d106149d5af51356113ab01c9512ad3cba96198013d"
    sha256 cellar: :any,                 sonoma:        "31b44cd66a7791aede3607246ebdf78dffe711b2699288b455f13921ceb90c7e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "811cddebea8e79cb94643ace5edb1f493e5baf00dc8dac89f17f7e7a2683a41d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a95681585835a5a79fb377eaba01a925cd1a0fe46ecdec7e8e5ca141a3667335"
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
