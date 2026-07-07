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
  revision 2
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
    sha256 cellar: :any, arm64_tahoe:   "7d9827f901a06d9d268d989a9a1cc8b9b1e556c0d8578a902eb36de5127d68e4"
    sha256 cellar: :any, arm64_sequoia: "930aa0b8b8be96e34c5d1adf3c1e17a11df6d1903923d512609456204c866b56"
    sha256 cellar: :any, arm64_sonoma:  "1c17edcbb22e124d00f82b785c7210a8c42e22f51af0384d70de02660c720096"
    sha256 cellar: :any, sonoma:        "73a586f7bca66526c3c150206163541117163aa145d40d7757aace996bcd2d02"
    sha256 cellar: :any, arm64_linux:   "a57357d9b0f8cd5d0c60952fc67241d508df3f40b601681936caf6a73869a6b8"
    sha256 cellar: :any, x86_64_linux:  "c8f12f67af0a1c86b07ad54de5d8ebac7f68ea758cf7382f288146c6daf1476f"
  end

  depends_on "freetype"
  depends_on "imagemagick"
  depends_on "libomp"
  depends_on "libtool"
  depends_on "little-cms2"

  def install
    args = %W[
      --with-imagick=#{Utils::Path.formula_opt_prefix("imagemagick")}
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
