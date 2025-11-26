# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "839e3f6c0988785db716dcf0495bc660cb2098dc25232873a819701f0f9cb991"
    sha256 cellar: :any,                 arm64_sequoia: "d0f67a12739f5b1233b0abd4c22f475d5956b4e0e16972763c17188e78b8cb47"
    sha256 cellar: :any,                 arm64_sonoma:  "98452325cf969cde8008a3a38ac5f73ac514d8477a3950ca67566d3b8d508a45"
    sha256 cellar: :any,                 sonoma:        "6c81effa7baef61b36013a52dd33d6162475d765f3f0ea2b0729efe632379385"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3b90d14e5847855887f32955e184c9cbebd0d1d63b130c027162422dea5b9e85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cb5ca0036dc94f5d3a28cebb4f378ad329e32f7973b8dcf6b5d493b775ba7968"
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
