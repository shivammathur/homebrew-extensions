# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "3037f4c0ac9915bf3e98ce155e87967d9b77316c7b368940f7557ba45048e475"
    sha256 cellar: :any,                 arm64_sonoma:  "8302367f315e809b23d6329817f1b3fd77facfad5b4c8113545cb6e99a965540"
    sha256 cellar: :any,                 arm64_ventura: "641229aa2379f2fd0a128b6d5d0d2c6be84826350873a2f8fcd5aaae774061c1"
    sha256 cellar: :any,                 ventura:       "0fa6531b13581ec1a3350ac853509eac1a272d8b766ae58e42d5e7cf44e04ed1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8adba4ad8874a22a0ffbccec4db84874873e3dec811d6e93cfa192ea0bbcbdf1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d9c3b90ad0a146a9d74a422c59fdec03a18851cf633f80ac8951caeab2b7000f"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
