# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "175e1ff162cb4e14282f9e95f1d90f3d2c58a2fe2ab1190e51ffec228d18cd50"
    sha256 cellar: :any,                 big_sur:       "f3d4881213e7fdcc1e296590092bbc2bb4dfce78cdecbb0583760bfe7ebbf5e2"
    sha256 cellar: :any,                 catalina:      "deae19fb3064ba0309b7880ba3b103ce6811e9cb9f4ef502bc61258bfaf417e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd8c60bc2a95c012cfca1e51957ad1a5a368fdd03ee7a1cf4a6a562c27232d73"
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
