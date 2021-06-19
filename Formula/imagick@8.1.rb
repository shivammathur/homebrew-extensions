# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/imagick/imagick/archive/3.4.4.tar.gz"
  sha256 "8204d228ecbe5f744d625c90364808616127471581227415bca18857af981369"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 arm64_big_sur: "823531059314c4c9d98121259474819ce6539429e712fb1daa289306abcffdcd"
    sha256 big_sur:       "31edbecf5fa3a56d2ee3d31a24b9b30406b31d6cfb5b9adc8db0bda3be53dee5"
    sha256 catalina:      "a8adbc23bfbb287ccbf2230b58268f098c6d94dc8da734c2e3f7cc3aa35c3c77"
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
