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
  revision 1
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e250c314e9c98190ad6c6651d40fa383863cd880e50ed8dfe7fd320ea55842b8"
    sha256 cellar: :any,                 arm64_sonoma:  "2bc3a1d6920d0fbf2c36ae71a90304f241ae3a1a559e8957c1361bad255f1921"
    sha256 cellar: :any,                 arm64_ventura: "91f0767a962c122ed39fff7fb1ad7d86bd8c91d02a43e6757672e6604d707dea"
    sha256 cellar: :any,                 ventura:       "90fe261af2f1d73d9a69d6fe0960a0f06f2b459f36ed8d0d07999f755bb68367"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3cf0656b844deb426805ac05b1f92708bfe895a560ad2ce3f44ebf2d1bf6c5f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "71b9e8317ab4c4d5bd0eeb10ab520455f878ca0dc21508d52520b4f3d183e117"
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
