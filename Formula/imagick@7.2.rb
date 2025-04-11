# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "5eb2cdffb522d796ee786abd83ad2d4c966b62e495735812c0ed8b80a6f807d3"
    sha256 cellar: :any,                 arm64_ventura:  "6e237f8b53fbedca20216d2d5d2fddaa31b1152191e3b7cca418bd1f920e75dd"
    sha256 cellar: :any,                 arm64_monterey: "2237168e304b09ad92eb5c3feff6221870e3d1f4c31752de3e12b06cef5b4929"
    sha256 cellar: :any,                 arm64_big_sur:  "b6c9b468da578709a5e1e6f51da8722ea10ff93bc5f5e9ce0d67c1ef6ee9c783"
    sha256 cellar: :any,                 ventura:        "a2d64049649b12ca3cdc2c0fd695d995942faef12fa8a308373f0891c86a70d3"
    sha256 cellar: :any,                 monterey:       "bd26ddc04ce700e66d0f1b461c870023d4246fef5b025ebe73aca6a037bf9218"
    sha256 cellar: :any,                 big_sur:        "582719a56451f3d1dbf49f38f08f86169b597ad798754ac55b9d006d677b325c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5451923b8597aaee277a065a03af01b0cee5069285a9217354393eb24c0e353f"
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
