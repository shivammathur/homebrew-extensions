# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "19198fe11fa4eafbe9540a0beb17e33fb6b77af647d3c7b2b2cd9d95731adb66"
    sha256 cellar: :any,                 arm64_big_sur:  "fdb20218019209322cedfd9204c2de7933bff5f8c789632da35d20c060965a6f"
    sha256 cellar: :any,                 monterey:       "164deac07dd9f80873473313f1b020b86e20ea4321283e8e2843f55845c681d2"
    sha256 cellar: :any,                 big_sur:        "24b288e2e0840e0c4e9dfecf455f260a282faa7e73a72714743a85d87862bd9f"
    sha256 cellar: :any,                 catalina:       "6d69f0ca14d586a794d85447f10f23ce38828f46d02e4537bef338d58056f039"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "43e8100dcc19c3e1df12a97bf0217907e3fa09e4d34d74a9a67459f7226c0982"
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
