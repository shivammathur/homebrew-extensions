# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT86 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  revision 1
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d71da5fa64ad9ef4080e8d71f9e231062ab8460371ee471a3b12987ea10d8946"
    sha256 cellar: :any,                 arm64_sequoia: "c119ac42b30f3d4cb2416ca8bf350be3ded26c82dd663e8e9fb64eb20695817f"
    sha256 cellar: :any,                 arm64_sonoma:  "2f623e240063059b1d8e53f4117c1719142d7448cbf16b7e8da7ef63692befd7"
    sha256 cellar: :any,                 sonoma:        "f3ed076235dd1492555772dea678b9b68f17b94ea3b430d8799633d08deb8741"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bccf86b686d9a358b61b23a869bae215ffa146b32f32a07a6d59ef7bcd4fb329"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "95e125288429913aafaf86fb6d66662f287caf83625456d8a6b2aabe255b4b08"
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
