# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "f321c1ebc01f7a377b6eb41cadd9c6d280a46edb9f4f45514c2d0d6d75c6f95c"
    sha256 cellar: :any,                 arm64_big_sur:  "3f499f95687a0d4cf134e6111e6107a26a123f7d954119b540715a88d44dfbff"
    sha256 cellar: :any,                 monterey:       "8aa883ca83c7ed4a2733c22e8b9fc9590b30cb334399bfa1cf102c10308f8fbe"
    sha256 cellar: :any,                 big_sur:        "ce0ee544a03272396ec420171a432c195b2674e7707b70fe00f14d1815e69fe1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "492b24eb4dfdbc13d0c05fa14833af09723829d3e3df949540081952f5d3319f"
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
