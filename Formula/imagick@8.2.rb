# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "0c7f91ec44ccab7b9d04c9416c5f3586a87ac48ffdc34bb1856c20c147afc0e5"
    sha256 cellar: :any,                 arm64_sonoma:  "2f9d83549371dd09faab749ee430f954628432d9a201a8e1f0014f94dd0f2157"
    sha256 cellar: :any,                 arm64_ventura: "7c022777f057e8548da54288811e80125875a2a5be370d16be3789c7763dea61"
    sha256 cellar: :any,                 ventura:       "4b9bc8c92fab74ee07da2ff16348bbae32d36ba4cb610b0c0f9df3ade6fbebee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b17afd2255877c6b8c514ebaeef140d5b9a7afa920e5d83e80643f5415df5b09"
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
