# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.4.4.tar.gz"
  sha256 "8204d228ecbe5f744d625c90364808616127471581227415bca18857af981369"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "b8186469a1dde9f508daae611ef93fe62b9fff26611406379671fe60c25eef51"
    sha256 big_sur:       "fa40e05eff4ebf407455f10ada6b7eebd6eeb082af4eea8bc8359b83a2bc0aac"
    sha256 catalina:      "4ae21a73fbddabb2f8b650183da850a51a01cddb7e2eff6ee4c6e4d4949619a4"
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
