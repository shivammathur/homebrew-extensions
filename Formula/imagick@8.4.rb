# typed: false
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
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "f18d74087448a892781c5e3d4c4d729ae3397e6e6d9b067aca3c2d21cb1a38ff"
    sha256 cellar: :any,                 arm64_monterey: "96115fb20db5d6ef86aa9dd8e1cf0ddc5c1b758a2401b12f82081bee0d924136"
    sha256 cellar: :any,                 arm64_big_sur:  "bab46565123bd7ca3e6a7d7f812aa04d516f893fff0ad9b6338b6e6876fe038c"
    sha256 cellar: :any,                 ventura:        "a07f671c2eb07fba1cc7c07d37ad977297c1d6861e1c796e95a4fb23918171ce"
    sha256 cellar: :any,                 monterey:       "2c72e180da84a48c725cd1f8b7f6c942b98db1248dcdf9f8732579ef1383b4ca"
    sha256 cellar: :any,                 big_sur:        "2a580796708789487a4d6f6a6173b0405f2a816aa0ebb44d98326fb6a3ba93b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "70f87caafd6fa89e873166eb0c7f5c5c97a880aca1c4fbadebad9b38b9c5b60f"
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
