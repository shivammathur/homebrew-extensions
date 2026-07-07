# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  revision 2
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@8.0",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "dd1fd3e5c05e2a9d89178a22d5b67946dcf1b9218235aa4489dfd56df15c6d7a"
    sha256 cellar: :any, arm64_sequoia: "791efa3ead39acba57b43e8bef2c5cd5df739420db98d03c7f0534eb88baae61"
    sha256 cellar: :any, arm64_sonoma:  "a35e85dfd196477ed63313d970f79a64b422fa1a4dd45638883db4dd182331f6"
    sha256 cellar: :any, sonoma:        "02f91680a753f94e4a0fd2e7bf22aa0068897576d51d9fe2e793da7ec8e0f38b"
    sha256 cellar: :any, arm64_linux:   "b62a4f5f085a28997dd0aa04f9e0afc10b3696dd071c1e1b0fc4cdd781d293e0"
    sha256 cellar: :any, x86_64_linux:  "ab159d28ecab7620c3fca2e0a1441b0f28b65001e5416a3dc8629bd510ca91ee"
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
