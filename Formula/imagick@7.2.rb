# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/Imagick/imagick/archive/448c1cd0d58ba2838b9b6dff71c9b7e70a401b90.tar.gz"
  sha256 "b1b32d524d11ffbd530b270f15205c5523ce81efde3c1bee94f4d2730246c867"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "239befd6017286bc24a2820af5ee3dd020de2d82e88295427370c41e4e266dd3"
    sha256 big_sur:       "3350f0b77a9871bc7c0b751a0b5ad94d6e88778de9d43db2ec2a815072952197"
    sha256 catalina:      "23e825ab2d13d46ed6e924060ec0aa26efcb356e41f5385f4934c9c1147c47e4"
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
