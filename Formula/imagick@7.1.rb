# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "8e5b6608ca71de26dfc1cdd0423a1380a5f4d2dbeef07c9dfd7129c234baf0b4"
    sha256                               big_sur:       "477f7c9140fc42c5454d124f5db26194f0f24861e5230a7c1e8e27d877b4f857"
    sha256                               catalina:      "2c5549e1e71fe47c55b032128404ca7c6af14b61f8f9b5749a582015613618ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8363b7fe55ea5a20441c6626a0ad7f6a8a151e6d7840960297e5e79a6348fda"
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
