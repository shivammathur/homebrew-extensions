# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "606324ed369cc7932a8e2c28538679d77b68a99a5d39f02e12f15a381b2639f7"
    sha256 cellar: :any,                 arm64_sonoma:  "0e76dd3cea34f22f3dc685c1873147842341f1c05a32ed3229cb2673e193eea9"
    sha256 cellar: :any,                 arm64_ventura: "c53b61efaae48feab19ea325251ca1f858b4c118c5f2fa511ebf16fb23f67369"
    sha256 cellar: :any,                 ventura:       "217d57e4b8d54e9b8e065e392fea7464624e000d5ae42a8c29ac830c6cce4307"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "97f00df9ee9ea0673566d8f0ff7cff0190e1f39336a1ca429857aca7d3f483f2"
  end

  depends_on "imagemagick"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
