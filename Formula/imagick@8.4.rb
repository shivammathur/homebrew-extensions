# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT84 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "f0c47440abc1e81a45d7788412f2bdeb77768ba077032a574b96e1350a0f0a91"
    sha256 cellar: :any,                 arm64_ventura:  "05e37526e0c9f61fc8bd655f377f9c9d9d2f4bf8a1a0daed502a61cdfb601d0f"
    sha256 cellar: :any,                 arm64_monterey: "3520102310c707708745da85e0b6c42895e89b8e8ec40cac5d998ea790235b56"
    sha256 cellar: :any,                 ventura:        "9fb3a0133cb724a5567196f23dfb8ff7829e9f9e2496ea6ac9e6d0e624d41133"
    sha256 cellar: :any,                 monterey:       "18441ae2287e435a4653536bab3cfd2f70eaf127fd0b62ae440f7a258fd6301c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9d7ce985940f7567716c82f1dad4670721fbf3a835c1f517f038e609ff267ee6"
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
