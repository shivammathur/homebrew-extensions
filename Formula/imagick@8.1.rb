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
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "41feccc65b3fd5e7b0fd1df32bc029570c8c916ef2473d9ae678ed06f05e1f12"
    sha256 cellar: :any,                 arm64_sonoma:  "8008c78b37dbefd14a03bb5a44444da33e4991fbcf62d1bc41f83e62a2c8195d"
    sha256 cellar: :any,                 arm64_ventura: "fc6a356307a2ad237cfae681a1eb3ef98ec0302dfc06c5c9d23f780ba83143eb"
    sha256 cellar: :any,                 ventura:       "5fd1ed3bdd94886ab946a33f8dab1a81c07e10a7b4c4897f47c4603133317d31"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8fd7d8aa7c72c4642c04121f247d502de79586472abe3c7df1a3fe1ea60591be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11df575d99c1fa131e16eefbe9bef054a7c7f7071c44803cbfb56fa1faf3fd6e"
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
