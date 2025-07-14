# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  revision 1
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "48b78db097c1561a3bc076998f043c897a1d8d1ebf391e1a762bbe9ca8864d0b"
    sha256 cellar: :any,                 arm64_sonoma:  "c6e1ca298b6833dd9598e2dcf666964db6a388d916c8ac3292078bbbc595d5aa"
    sha256 cellar: :any,                 arm64_ventura: "2799a0140d604ade35b0fc6def77f1b5bcf1120165c21f7388eb092f911ac4c2"
    sha256 cellar: :any,                 ventura:       "3e0ec127b91bbb55969af93124a555183721adbc28d711cbc144a42b930356e0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b830ee6f35b6dbee2aa1cc60d104f2646bea9748e3331456fcff4824ee8a54e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a36addabf41bedcfb51dc0b3127f9cec492a5fcccd529e00ee9255b0c52d7536"
  end

  depends_on "imagemagick"
  depends_on "libomp"

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
