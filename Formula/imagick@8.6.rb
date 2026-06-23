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
  revision 1
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
    sha256 cellar: :any, arm64_tahoe:   "08b55b40992da5c94ee0e0a726d45ddfab7614cd7c45e6d888300132b896d5c2"
    sha256 cellar: :any, arm64_sequoia: "295a78f454290f090add92b9558d8380ab2e6bd0bb88e0d9974fa40c65a346b7"
    sha256 cellar: :any, arm64_sonoma:  "e591c3afd7612527ccc1acba5f3b234da3ca35722dd5fc4dfec0f54490227189"
    sha256 cellar: :any, sonoma:        "9babf0929834fe70ba8ecf5258b6bc9596917901fc845c4088ed029dc40e622f"
    sha256 cellar: :any, arm64_linux:   "99fba12f1b1d32824df0900d1e23c233445463479f7e8954c26464f3322633fe"
    sha256 cellar: :any, x86_64_linux:  "d9186943180faece5ff44c51810bfd0a8ee20d298faa44342c87d818478b921b"
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
