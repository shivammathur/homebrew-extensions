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
  revision 2
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
    sha256 cellar: :any, arm64_tahoe:   "e6806cb070165521c5fbeecb0e845de98c52344402ab55855952520f96f3ed39"
    sha256 cellar: :any, arm64_sequoia: "17b2ba00118ccafa4b099f8bc8d05f2fc510809ef308234eeb0e216b2b7bdb0f"
    sha256 cellar: :any, arm64_sonoma:  "0cf4ad5022e1ffa851960c914454004888e8f9ae3ee96c917789b3d372c56ae7"
    sha256 cellar: :any, sonoma:        "1cf72a754c04fae309a9f7d51b385c219108cf815d77c28c718bdefd57a42a4d"
    sha256 cellar: :any, arm64_linux:   "c26decf00b23c04d78407ed5e063eec08ee03fc6d83c5dac4096ea04bf25659b"
    sha256 cellar: :any, x86_64_linux:  "42b81f997ca210ea0256797304ee79b6f31885a158077307c639edbf891e000a"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Utils::Path.formula_opt_prefix("imagemagick")}
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
