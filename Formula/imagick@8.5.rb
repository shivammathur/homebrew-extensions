# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT85 < AbstractPhpExtension
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

  conflicts_with "gmagick@8.5",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "9e1be576ff51de4099b4747efc4750c8082e636ebabd9c8cbaf31e40fdb912a0"
    sha256 cellar: :any, arm64_sequoia: "ed571fa4858214cb8aa60fd9ec539a7dd935b1586988ff40875cce0839f4b702"
    sha256 cellar: :any, arm64_sonoma:  "780db3918144dedf97697730b77a5ae1d7769e36191a7d246c627d593682ccc8"
    sha256 cellar: :any, sonoma:        "090a73eba76528ea5e10cff9b29f2432a9c958e3d6ec49a168e58b956aae5896"
    sha256 cellar: :any, arm64_linux:   "ac58accbc6abf50adf8d613c41a0c30d40e4f8f1aa0927d2096fa0fb63ce0fea"
    sha256 cellar: :any, x86_64_linux:  "c43f25ae97308798fdc833d4aa36b7669ba31f1ad528c24baaa50da312edc778"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Utils::Path.formula_opt_prefix("imagemagick")}
    ]
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    Dir.chdir "imagick-#{version}"
    inreplace "imagick.c", "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
