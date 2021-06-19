# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.5.0.tar.gz"
  sha256 "f32fb86fefb8531fc32768b9732305f8ada14f249cf3b74c9aaa664c6ae38c27"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "69ef4a646a367f47daf2fc539a26c035cb41b5afc9978242c39709a643d4f50e"
    sha256 big_sur:       "8493a42a654470d4b7ae0f1a817e3bcdd6f879e94044ffd3426201e7e7c3f5ba"
    sha256 catalina:      "a4a429b45a0a264424429bedd78584838756002679246ec28b5d7b5dea7d3cb8"
  end

  depends_on "imagemagick"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
