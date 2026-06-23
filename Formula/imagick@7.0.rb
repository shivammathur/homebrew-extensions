# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  revision 1
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@7.0",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "2735c1563f5aa0bcada972059b5864beb9ee97d14ee46423a88c18e32260bbd1"
    sha256 cellar: :any, arm64_sequoia: "a6c3e8b1d7dd143b24d8730a07ce5ce6572ec3232ad64797ad47bf0268b51295"
    sha256 cellar: :any, arm64_sonoma:  "227ee976526180b5f2b4bdf39a56c7c3f0e55451fc349dd5f0ee2f6c76b2d68b"
    sha256 cellar: :any, sonoma:        "3c8421244cb78be8318d79333533ccb5afcaafa7f50fb134f7bc74bd0bde9c06"
    sha256 cellar: :any, arm64_linux:   "83ea6ca205e169dfbd5b52dbfef826d0fddff0b2721529f7dee0fe3bb7aaf200"
    sha256 cellar: :any, x86_64_linux:  "9b9c940f36d46701d2b53af48a3a176a0a806ee1c504c07dbd8f798e8be57064"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Utils::Path.formula_opt_prefix("imagemagick")}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
