# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@7.2",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "26267e3d8c7be28b2727d238e98a7832764219614a1c4a0784caf13d68266c02"
    sha256 cellar: :any,                 arm64_sequoia: "8569126ddab0572ed4ab315052092de386c5595b7681312faf30e7e8212b1daa"
    sha256 cellar: :any,                 arm64_sonoma:  "f14f5abcaa14f2bff2df2b3d61e7b52756ca1379cd84e0340dc03ff511c2ce2a"
    sha256 cellar: :any,                 sonoma:        "581b83826b2fdaec37859497758cc8b6cd4a097eeaf599fad7ecfc55318af78b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "57c28af240ebb9790b78431b3777189e69b9271981f6b403d0d35f0120dc4e08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c07a592fb45a1642c0055096949fe60ed2a61f68f6ba4c77070e0811c8ede8c"
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
