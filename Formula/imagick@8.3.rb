# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "a9b5600c1ab275eedcd9c6cc70dcd90d745700b994b2c13cc3f4625f3f4d88c8"
    sha256 cellar: :any,                 arm64_sonoma:  "dd32222ce59aff19a0ba9f7e66a8bd9928cdd8677ffe57c689163e3d9d8cfb32"
    sha256 cellar: :any,                 arm64_ventura: "bebc340b16acb1fa3ef82363abb57a52c69ba02dd028f0a49af9514b7052913b"
    sha256 cellar: :any,                 ventura:       "d0eb26e53fe50cf53e50fc4d782cce28034e1aa7a196b9abc1f4fd2378c80d7f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4b07237beb25beedc71a5860833aac595e63d25e074153c7d0bba2a8ade4ec47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a18788f20cd14bf1c3bdc2000f7164d3687250c5e8567b6b44ad701138183035"
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
