# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhp73Extension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick/releases"
  url "https://github.com/Imagick/imagick/archive/448c1cd0d58ba2838b9b6dff71c9b7e70a401b90.tar.gz?init=true"
  sha256 "b1b32d524d11ffbd530b270f15205c5523ce81efde3c1bee94f4d2730246c867"
  version "3.4.4"
  head "https://github.com/Imagick/imagick"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "f38efd8bcaa1bd159455c405cd270134cd4dc25e30184ca7f3c8334fbc985abb"
    sha256 big_sur:       "3741af604eee909983bd54f67b51d7932f2a0fbfb1f81a44a8d8bc85a345c6fd"
    sha256 catalina:      "52f96cd86a72294f0b0f9ef21ff0daec7041c28ced2e944397ccdb6d30f8c349"
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
