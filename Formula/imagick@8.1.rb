# typed: false
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "8474ff6e47dd4a22c8ed6323d47f2114e4de5a90511e5f26c1ccc741d53745a3"
    sha256 cellar: :any,                 big_sur:       "230deb69ac03d015f25fe23fbc1085fa8c1d2298682d0a8593ca179b7a22e4bc"
    sha256 cellar: :any,                 catalina:      "389cd61d9143bc49da9defa2b005948507077d6da51a304f25009ad0ef24e5d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "87a82852bd735ae6eff0debef6e02e97241cde387294bcd2195ef5fdda149747"
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
