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
  revision 1
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
    sha256 cellar: :any, arm64_tahoe:   "dc6de250c927d867fefdae39d5f67d8035353d91cca842129d06813f3c2f51a7"
    sha256 cellar: :any, arm64_sequoia: "444cc8b0dfda50094297577ccac274629c90d9eec70d3988c9c6ec0da0af9f6d"
    sha256 cellar: :any, arm64_sonoma:  "a052839e0dff514a4050d7b8b1a0bfea238cd2d556ac0e23480237a465d01d89"
    sha256 cellar: :any, sonoma:        "a2ac2206d7d84373771f491eadb0efb51190a057089b3dc0a4495248f595e269"
    sha256 cellar: :any, arm64_linux:   "7a6835d47b449bee014fe84e46df65a375a863649f1f86f51b4b849c80312611"
    sha256 cellar: :any, x86_64_linux:  "f9a4c68aa7d20d61f7c84bfeeb44e7525bf0f786f46fb9f88b4cb97b88a1563d"
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
