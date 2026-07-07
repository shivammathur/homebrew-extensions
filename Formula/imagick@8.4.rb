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
  revision 2
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
    sha256 cellar: :any, arm64_tahoe:   "8a9e046edadd97fb7fcdd94b7b48b825e75b753d3f57b77c064a6449a88a3579"
    sha256 cellar: :any, arm64_sequoia: "d262d4e9fa25f215fb3f23bf0048e70326a81b7f6576ff55e78e65bfde169ae2"
    sha256 cellar: :any, arm64_sonoma:  "19c971dbe8e65962de96a64b94ce5d052eec6bf441493ac699f6a9c41c601a86"
    sha256 cellar: :any, sonoma:        "9a733a6fa34d05a408b9b27c37eb5c4346eb1c0992360e4cad896973c1dfa475"
    sha256 cellar: :any, arm64_linux:   "b9ee5c499ecd300a7d8557123f6bccd559d5bd9c2b3ad94309c3794bd4a2975c"
    sha256 cellar: :any, x86_64_linux:  "b1f3421255d84be4a9c7bff4b9cac6e978ae22e174be8b0f93ec635c780327ea"
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
