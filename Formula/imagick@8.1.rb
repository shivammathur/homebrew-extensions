# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "1e4d2ab329735f01840040f9b314c968574e88421eaf5b87d274552f20abf715"
    sha256 cellar: :any,                 arm64_ventura:  "19b72f476fd14dc2a8335aa1c7033cf261873eab749008a69fdd8bced8c04d7e"
    sha256 cellar: :any,                 arm64_monterey: "4bbb77e5251ad646ed9d4a583264be9d5d01c573c2fafc268eb8096312788814"
    sha256 cellar: :any,                 arm64_big_sur:  "ffa39ff9606d00c0c0b8b48bf0450e2678c62f97c9747c137e01946721bc029d"
    sha256 cellar: :any,                 ventura:        "25fe7f9a8c3b0c77cc477a169f26171b50ca18337b1cc51c7df871da6cd31166"
    sha256 cellar: :any,                 monterey:       "55b23c595457e9a8ffa58bcd3c199dffc23885dff017d5437ad354968dd8eb35"
    sha256 cellar: :any,                 big_sur:        "e5c81b62c813d47bd2c1dc0771b5c39e19e653844db56c265986324f0a867b36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "61db2d569465b716f25e94cb3f32ee8d8bbee0ea84751994a73093cb8b9410db"
  end

  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
