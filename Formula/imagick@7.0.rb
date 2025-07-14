# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "69195395c8a1ff26eaa3469aaf518b6bfc8523b206bafb7aae67b26fab3d6a22"
    sha256 cellar: :any,                 arm64_sonoma:  "b25f605260fe2b9dc2cd10fb3f28701e24809421ffa405ffd70e9e46225d6106"
    sha256 cellar: :any,                 arm64_ventura: "68127b1b0cd4c93bfb5a7fbd30ac8cf2d899b935a13ed314fd11d5ecaa7e9558"
    sha256 cellar: :any,                 ventura:       "4796a5afaf72ea2db7f39db1abdf07998da85268b8447c47319d25a3b241f6a4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "636e037cf0f9b285e32bab96e090d08fc69404223f93d73c64ba0c9da0e7769a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa753ae764e85e80f4c5f89cad61e370a9566f208cd1cc736a6def8928cce2de"
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
