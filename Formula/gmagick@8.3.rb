# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT83 < AbstractPhpExtension
  init
  desc "Gmagick PHP extension"
  homepage "https://github.com/vitoc/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.6RC1.tgz"
  sha256 "350cb71a4fbd58e037c7182cafa14e6f6df952126869205918fcc9ec5798e2fa"
  head "https://github.com/vitoc/gmagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gmagick/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:RC\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "8aa5fd5e6062c3ff05d82acf7e4bec5d7fd5d02d1b8623cca2ed548a97d300b8"
    sha256 cellar: :any,                 arm64_sequoia: "d428eebe602c2d2c1fc22b092318a4e08b2e66593006bd2f7179071758067f3c"
    sha256 cellar: :any,                 arm64_sonoma:  "4cf8ed06a3d856e86908d0dcee8d49d276ef8dfde0e4d1cfebdc36d4c34d1731"
    sha256 cellar: :any,                 sonoma:        "c8a9f88e4bb41586c1287b2233bf363ffb4d142e687797093950560a7258c703"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fe9b45c1dcab3fc2e2734b5221700701bb6ab98939f269d7e47d6c6c1a37cd16"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9340710a51af945c9b75a1b618768352494521a72b9600f4d545175415124344"
  end

  conflicts_with "imagick@8.3",
because: "both provide PHP image processing extensions and should not be loaded together"

  depends_on "graphicsmagick"

  def install
    args = %W[
      --with-gmagick=#{Formula["graphicsmagick"].opt_prefix}
    ]
    Dir.chdir "gmagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
