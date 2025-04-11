# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
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
    rebuild 8
    sha256 cellar: :any,                 arm64_sequoia:  "ff450ca52e3b80578cf5cab745d2cfec21115907253822a7a38bf00434868f25"
    sha256 cellar: :any,                 arm64_ventura:  "e80a50469a1fbbef80fa656fe3134f76e6492bd2ae149412dea5096849540d90"
    sha256 cellar: :any,                 arm64_monterey: "64b4a0fc45b93167ccfb03d5a6b810ee0ba7780b6e21a04793cf15b016ea16d7"
    sha256 cellar: :any,                 arm64_big_sur:  "99320e508983dd3eac8dec25bc912b0aa5756443ac202449a8706e59a3d80726"
    sha256 cellar: :any,                 ventura:        "36ebe482a5db9aa51b5268d322b86883a8f382647f7e6bdb72d4b39a72b9986c"
    sha256 cellar: :any,                 monterey:       "0ede2643f690462b3cf9055439ca467a6daa336a55259e5b0382325ef4143603"
    sha256 cellar: :any,                 big_sur:        "15040b85b36062717e18c28cb8e2458ac4ababfdcc8c7483f42af674c2d04603"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2ecd387ece0560314ed619f83fb92f08064fde61c174c6f6198ed53acef068f2"
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
