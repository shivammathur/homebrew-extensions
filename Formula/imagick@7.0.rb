# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "fc644196b6b6c187ca9910d50e5447291505d7dd7b360d8a41c7221ac0d349d8"
    sha256                               big_sur:       "ae808f5ae2fc7917e182efb3a813612a1bbc981fd2f3eea586924a66f48fcaf9"
    sha256                               catalina:      "67287878064f555e2b3836d22f0f9e565ac6e8b3689e00b2596bf0a2c69f7136"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d24d4e48bbc21a14a5d0ec5cc01731416ab9e1789e2a78ff019b431bdd7ddc2"
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
