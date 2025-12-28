# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
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

  conflicts_with "gmagick@8.3",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "3e79045c81708922c5387d20b2d4266d50d7c748c9b582eb6a1c364d225c486b"
    sha256 cellar: :any,                 arm64_sequoia: "66470056fd2b3e2d1f819e9f97087db3921796452d9f0c0b1cd79b9b8c224f31"
    sha256 cellar: :any,                 arm64_sonoma:  "84efb9f4632d3b5e7f798604c7a922ccb551d2979fadf65e98d7e3f27aba7eb1"
    sha256 cellar: :any,                 sonoma:        "d055800f219d3d68140aafdc5b88a477d9e4c5be81dfed7559e187626735d1e2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4987d9f8423438d76725f04d848b43a746c7138ccd320cfeef2f7d091ab8dc17"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e87ace205efa872225237b2043f25e427590d42632e00deda0a8605af028537"
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
