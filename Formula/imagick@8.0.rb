# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "ef00194a6f1ebb678f408ecf9de02a252b72cccf754a4e08f7b91ab5053c808c"
    sha256 cellar: :any,                 arm64_sonoma:  "37a1a59cfbf3f4f87f12d54b5cb3584d8e786e3cff383c05ecf15f84dc24d817"
    sha256 cellar: :any,                 arm64_ventura: "81f40bd081d7d1720a186b228522b377c7c3ee8c2982e8afded16cc72d694a8e"
    sha256 cellar: :any,                 ventura:       "5c61e6fa77ecf23e5a45fd7ab759b66d6a44bca3c5d73b71abfc6046f53350d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82ece2c6402b93a647b8d4594cf41087144ec77b00916eb151921b97a8caeadd"
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
