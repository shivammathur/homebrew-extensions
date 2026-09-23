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
    sha256 cellar: :any, arm64_golden_gate: "e935948fabef6c6460988384d1397487b52f30f9e7a63d78590f62c3b0cb132e"
    sha256 cellar: :any, arm64_tahoe:       "3cbd1b04406df3fab8692a8aa395b520365c78811080e7a61ef871aa18ea9936"
    sha256 cellar: :any, arm64_sequoia:     "8352e092e6b9b419307d124f9254b12328ae5052efd823661e6db2fe890f637d"
    sha256 cellar: :any, arm64_linux:       "e33af03cafdb9a21c2dd49d7c5361548099ca2448c0ad4f9b24aafe62dbec001"
    sha256 cellar: :any, x86_64_linux:      "ee01d4525c7d8b5323c270a205a87751144adc4565877f882ca7b9f903ef8e71"
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
