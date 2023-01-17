# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/imagick@7.2-3.7.0"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "7d5b0f2c2a13a6de623654740ba52f35ef3e0281b4a4e2829727025863744a9a"
    sha256 cellar: :any,                 arm64_big_sur:  "0f59ac9227ff49802f644517b271a72ec72ec9dd57a1651982008fc18178c5d8"
    sha256 cellar: :any,                 monterey:       "e0eefbecf785fc771e6b23ee10f7e875b7e1e7396473bd41f4b097b6ab6d2d7f"
    sha256 cellar: :any,                 big_sur:        "410ea016905f4237fe3bc3552ee5aad39941ab2b9ed490c8f70e61cb42a1365e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd465cea5f6ba512d1cff3bb3481f15994abab368c0f91cc128f8fece5d1ee3a"
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
