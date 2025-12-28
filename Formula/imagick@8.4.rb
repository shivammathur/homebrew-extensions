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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "cbbb424a5ac19df6d782e96c44beac02194de04e976d50b23e5a4ad8d475944c"
    sha256 cellar: :any,                 arm64_sequoia: "210f146266fc4c47f78176a68ac066d5d694094bb772b56b6af9a2990018c033"
    sha256 cellar: :any,                 arm64_sonoma:  "3fab56403853ed23e1ac7b29317c37515b04d6258f4d377fa0130a68497643e0"
    sha256 cellar: :any,                 sonoma:        "45b884c5c3717d0ebe12a91f1b70b8323a2d5eb793d16a75858c7b0a49d748bc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2bef16f755c11e82ec086a8c416acd47aa63a6c395b7127ecee7b3cf14f3aa42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "07aaef0502862957141de897f040c4114bf97c2b89f30d6a3c49e8cd8d49980d"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
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
