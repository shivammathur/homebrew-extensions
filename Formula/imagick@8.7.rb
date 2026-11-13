# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT87 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  revision 3
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@8.7",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "eef30406412646ded95444997bb098bcf0833c3f6bc6e0ddd61e8870bd5ca53d"
    sha256 cellar: :any, arm64_tahoe:       "2e9a2221dfad4475eef236001fad3f8f723500d345377420da20176904dda81c"
    sha256 cellar: :any, arm64_sequoia:     "8760ecb811dfb40df627e08f467ed8e98b1466e1aca68b6df8ca3291702b15a5"
    sha256 cellar: :any, arm64_linux:       "604bca2f6bab1016dd7d8a9c3af2da42b5a0bfc73c345beddeffd54130ba67ff"
    sha256 cellar: :any, x86_64_linux:      "98acf1532cea34b9f407becf77bc893d7d6c385ff5b650d94f669dbc3c8ff8bb"
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
