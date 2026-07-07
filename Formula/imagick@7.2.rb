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
  revision 2
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
    sha256 cellar: :any, arm64_tahoe:   "03849b5ca6b82277ea41a976e482721e20a4477895f08db50ec272d7d8b1216c"
    sha256 cellar: :any, arm64_sequoia: "b6bac3c8209dbcf45f8e64595a73317998d41445552a94e1cd00a7ade755c053"
    sha256 cellar: :any, arm64_sonoma:  "9c8b6fdcc66483c1d6dc8239f30f253a3d9beb4564149d5c873ee3d5635cfa32"
    sha256 cellar: :any, sonoma:        "1bb15f9ae231ec0c650f5e810db97eb4e752a049d5b802744de7636fb8824cd5"
    sha256 cellar: :any, arm64_linux:   "fab5dec22f368284168a6f35e355ae0acc6879704178deac24e93a8a82f9ade6"
    sha256 cellar: :any, x86_64_linux:  "2e809fbc341a208c8c4a041e25ccbb3c3b25ee715955a6794ef3906a39c75e1e"
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
