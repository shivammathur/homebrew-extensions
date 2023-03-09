# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "3384ef116f2a78b7bd8565d05ea527fe67eddc3b61486469332a43a77ea06a30"
    sha256 cellar: :any,                 arm64_big_sur:  "ad67354fe18c8ef59fb12cf014fd62bd8684c45b955cea531fdc7465f1b1b65e"
    sha256 cellar: :any,                 monterey:       "1141569904b24cf80021728f9bec659c7ab164aaa75a8ff3a42d74f910794564"
    sha256 cellar: :any,                 big_sur:        "58bb604676a9bb827f873b1a0e1fe552412f164910772ae33825a5106b3bf880"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2de0b9c0ee7acb84bf9ef8794b1fbb34ef3a88478951dca64ec3b7dcf7b10286"
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
