# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT84 < AbstractPhpExtension
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

  conflicts_with "gmagick@8.4",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "04c87e0e5c253037d05c83290ea0ca8ba261b0048f1408db648a3d3d23b0c60d"
    sha256 cellar: :any, arm64_sequoia: "2907342711376b2ca3576909956ca87c926110704d24bd68b232ef8463ebfc09"
    sha256 cellar: :any, arm64_sonoma:  "3bb891c3614f09c6af786fefde547c9e3ceaf5f1a103d4d3870936a6d2dae67d"
    sha256 cellar: :any, sonoma:        "a3d1237bf07a8a41a70ac8283f91e0851ef41a0c6ff2c2c2f0a2bfd4c58c6c56"
    sha256 cellar: :any, arm64_linux:   "7ae755be966232ec1146c3ac5d1289b58dd33007c741e6a5071d09c74a1df090"
    sha256 cellar: :any, x86_64_linux:  "674cec2463d246baa3539f8a5bbe7f0f25a2c52c227d26b5fbfa5af7c477c2ea"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Utils::Path.formula_opt_prefix("imagemagick")}
    ]
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
