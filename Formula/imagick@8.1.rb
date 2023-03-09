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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "229cb63097295a5bbadbe63114a2dc8d8e885246d8c3789a68cc1641e5fb6a29"
    sha256 cellar: :any,                 arm64_big_sur:  "8c8995822ee0344bbc602bfe284d4b1be0442e4576bc54befa833ed81ae0dbce"
    sha256 cellar: :any,                 monterey:       "cfdc06e236e7c91f4cff4f3d9cdfd67d8d4c18b8d0c41e0c2947f9e8c9e606fd"
    sha256 cellar: :any,                 big_sur:        "ee6f55c23ea7995ae06dbbfa60e919c980b4065f4e060c6e0a1987223da81c97"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3327078005dd172cef75aad595d2510a67be625dde714ff7fd1e926d35468b1b"
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
