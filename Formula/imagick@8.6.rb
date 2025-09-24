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
    sha256 cellar: :any,                 arm64_sequoia: "5586b2d7c3a3fe92627efb35cdbf3a15ff63190a6eae208dfac697872f5f1066"
    sha256 cellar: :any,                 arm64_sonoma:  "1d18e209d41fc2d45086c87617330d2ccf9ef64692f2af343adba18f22714ef0"
    sha256 cellar: :any,                 arm64_ventura: "5e1bd7ca4893042eb98631ec4a0edf04feb5d5937240491091dc65ca77147f8b"
    sha256 cellar: :any,                 ventura:       "66d5d837fe6e4218c043b0527eff66e086ab540d1e43f053f01029c5f2229a5f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4365d8288191fa4bbe1a645bab0a815b0fc72cfbf1a2c2d1709873fb0e3fc76f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7dc829e28e6ef85fbb5298d779ae414ac4dd8ae3f3e14abae8cea381b7b9da00"
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
