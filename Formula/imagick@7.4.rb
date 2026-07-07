# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
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

  conflicts_with "gmagick@7.4",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "5e57681a4e608a934d967fcadee88b17f41c2b7a20562f2e0ab678f668cc540b"
    sha256 cellar: :any, arm64_sequoia: "4739f7c24b8d72d594d859aefe19b9dad8efffa3958a6e6a9cf7a8f8c6c64798"
    sha256 cellar: :any, arm64_sonoma:  "2a672256d61e86c1642ddd98583660d360d26150e6fba01822f498ac93ed9883"
    sha256 cellar: :any, sonoma:        "72e330eb2559dc16b006ea387ac3289b716c159ed07afc5dfe4e94345baec8b9"
    sha256 cellar: :any, arm64_linux:   "80ba507d5a15491576c98bdd9c3501e8aaf9a6ffe585f535e8e7211775742d2f"
    sha256 cellar: :any, x86_64_linux:  "40699b81cef1d88710d2636233a25636e03c76be39097ed4e73432f3b8879896"
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
