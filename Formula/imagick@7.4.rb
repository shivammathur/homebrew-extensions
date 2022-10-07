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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "fe32f0b12cf4dbf873cfe992a33a6c5031d14215e5d6c57342968698f40c8c8e"
    sha256 cellar: :any,                 arm64_big_sur:  "caa3f5e20c13b4c92504f29bd337006c72ec999087a86823ca0c4accfa076a6d"
    sha256 cellar: :any,                 monterey:       "4a7ee17d6ef1dcdd8d7bbb8ca5fd237123c3c9ebf34e103e2951f7903d146634"
    sha256 cellar: :any,                 big_sur:        "07f4f4c563cf3835358ccbc1743f2b1933f1b9ed139522dcb691639faf012b55"
    sha256 cellar: :any,                 catalina:       "78dab8fcc1816d8010bad78e8a599bd7530bd7f1971436600fa569f9f5381248"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4dc3fa9b976ef368546c3b604851c22538aed6b034cdc20d774de3c3e4d579e2"
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
