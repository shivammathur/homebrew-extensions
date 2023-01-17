# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "c7a1e279974f57260636eae7a76a937a0556daa0aa41cb1bf7e446e9040701a9"
    sha256 cellar: :any,                 arm64_big_sur:  "02f855c3b9c409b26c0cc9dcd94d4739bcb70ae54346678e3071075f0a9f81ad"
    sha256 cellar: :any,                 monterey:       "df2a941e2870b05c15904f26ab55b65938d2c3fe72611c8ed7ecd174bab15400"
    sha256 cellar: :any,                 big_sur:        "9db7e1f0901ee0cc0e90369a8302cd240fadff244aa6cb9adaa31cf1b2034398"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "88a76fa5cb49233bb8f747d288d6d564afbcfb1bd2ab846469d751da8db53e8e"
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
