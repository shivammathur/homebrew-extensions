# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhp72Extension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/Imagick/imagick/archive/448c1cd0d58ba2838b9b6dff71c9b7e70a401b90.tar.gz"
  sha256 "b1b32d524d11ffbd530b270f15205c5523ce81efde3c1bee94f4d2730246c867"
  version "3.4.4"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "7b1e8c2d53b0046507373c7e7ec70eb1e283f3e56a65f535731e0470ba00d739"
    sha256 big_sur:       "ac54bb41483a23961642938d4514c768cb035e4e1aa8814bb9c8234012faf867"
    sha256 catalina:      "f6acfd0c2370a5eca7177774d4b009a6563745a5df3a251a13f99db6ecd4ce4d"
  end

  depends_on "imagemagick"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
