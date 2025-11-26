# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9821d0352019a70ba90491bf894703d5e05f48b58192817f11b353e8b77760c0"
    sha256 cellar: :any,                 arm64_sonoma:  "e7e14d9560475d41f8cc6db4b33b18b1cf0d49021b519a9d296ba08e33690299"
    sha256 cellar: :any,                 arm64_ventura: "06f141e950fb3579d050c3200ebc2e11ff1f9a6076fb078282ead3f04e8c8eba"
    sha256 cellar: :any,                 sonoma:        "149762c60d65d59c9ffdf54cefc2bbb4e301b6acd30b0e5c15a1c481be42d34c"
    sha256 cellar: :any,                 ventura:       "400ee8a055fa1c3fda3514e06be32a6780010d97ad77108140a219cf37226b27"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2a3e0fb4081232c7d0dde89b17863497aedbe3b043f6eac13ad6a25c3be53d71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "589703beccb1ce8b72d60a3036dff81f760fd9745da3a60141d2f6bbd54a1cc1"
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
