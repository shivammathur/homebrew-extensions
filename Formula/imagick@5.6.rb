# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.5.0.tar.gz"
  sha256 "f32fb86fefb8531fc32768b9732305f8ada14f249cf3b74c9aaa664c6ae38c27"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "bd54f74cdff910e117afb3f0806ebbeb8628d9d4ae439f47794e5ec547b92aef"
    sha256 big_sur:       "f25eb8f159816a9a1361a5bdad679495113cd76a6edff8cbd6069db132e58b60"
    sha256 catalina:      "d0dc63de2f6497896de6c3ecd45e59c867c933dba41cbe3fab6b88a7f1230de1"
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
