# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.5.1.tgz"
  sha256 "243ff2094edcacb2ae46ee3a4d9f38a60a4f26a6a71f59023b6198cbed0f7f81"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "c70ffdd34348d0d197fc15cdf626adf7d9ba5a5c2c4978e92ae8edddcba2d31b"
    sha256 big_sur:       "bc2e4e6bd5e0b9723be2b2d1db55863c16e8c4e97299588f519da75e18c018ab"
    sha256 catalina:      "9e700184aff54c543210524df7a4a921c0e744fc55230387c62674634ebaf6fe"
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
