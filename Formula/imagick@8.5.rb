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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "f1a8cc62760df35953bfad2526d2218075ce15461080d7554aec2c709046a8da"
    sha256 cellar: :any,                 arm64_sequoia: "251e2750f5e03dd60ec381d838d5fce59901b55070f61601dd511efd52eb07a1"
    sha256 cellar: :any,                 arm64_sonoma:  "98b9c8b5a9fcd7b8c99d4b8cd99af47a8d2f997719ce40bd724acba26654223e"
    sha256 cellar: :any,                 sonoma:        "7d644b000d005d308c3ba755bc1166bc5f7a8687f4c5149e0092da9d31782d20"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ae62a592f72849221c9062898336c599f694b08fa5235029b01d96a6ae2949f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a9135ff9752bff7a0e3f97febe78d701124403083bd3b5ddebc9f1b0f17d8b2e"
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
