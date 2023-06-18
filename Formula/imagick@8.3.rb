# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "84a12cc8179b810f573df5fe7ecbaac819194aab20352db19900131a372b1951"
    sha256 cellar: :any,                 arm64_big_sur:  "88f81b346fa64db49a9c500bcb8fb93f95b2380efbf0d46c3f5c796d4337dd87"
    sha256 cellar: :any,                 ventura:        "c4ce52281326e821f976322a83852a92cde4398db05704d5a6f84abffc3b8527"
    sha256 cellar: :any,                 monterey:       "a95b5331af14827f0e3e8aad3688daaa46cb4aeee47129402f706b58d8a4d603"
    sha256 cellar: :any,                 big_sur:        "402583bb400a08217472991fea0e337256458dd0887c652269cb4af36c0df0cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0c25bfb32b1a3437233482dacbd4acbdc08580ed15c9114bbeec57b1a934d5ef"
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
