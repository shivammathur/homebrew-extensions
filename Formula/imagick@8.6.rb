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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "da21161653d13e8124603b70b74bc5b5a6d0b6e54ce37ec1b968de32b22496c5"
    sha256 cellar: :any,                 arm64_sequoia: "0021fb7108ef7883ce56c0dbac018a23332a8c5ea0fffc5406eb82df1a4134f6"
    sha256 cellar: :any,                 arm64_sonoma:  "703fb85a8c0b4213f4cccad265648d1c9d4375a9fc6dd64a8027a2a343b8c2e8"
    sha256 cellar: :any,                 sonoma:        "2b9b5e0e5a38931d33ed8ca0b107f8d7488ca28e7d28173baed5d9fd1867b6eb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "526607e5f2a8b60a695b80c4434011ca581b1d2120bb39450ce97323f974877b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7df86d2f764adabd33285fc760daa3327c56111707b3daa332f94ac28b7fc70c"
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
