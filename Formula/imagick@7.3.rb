# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
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

  conflicts_with "gmagick@7.3",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "a80c1a7d9add97250d1123d13f748226174fe6716ea907f60223dfe15e5e8b4f"
    sha256 cellar: :any,                 arm64_sequoia: "3a266fba4acc206f7b187e671a3c61dbe6b9f22888deaeb453d4b22b712bf144"
    sha256 cellar: :any,                 arm64_sonoma:  "1e86f6ee99f949fcb2ef9e3e3db8ebcf2cd9dd29f0120e78b015f73c6ec92eb2"
    sha256 cellar: :any,                 sonoma:        "e0245e906dccb73497d813802ddda3e3dbc7c05dacfd531a1dce7f5a120052c0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5d56d50f4abc35cce98a18bcb0034ce0b1d0f41cf08241694cde2aed46ecf048"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0632aecd88ddfb819d47a5de3e747cad7d95ecc952284b5d5bff25e0b94631ba"
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
