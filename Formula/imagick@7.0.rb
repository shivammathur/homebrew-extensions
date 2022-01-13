# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "ac26bce66d7ccb9c61e6de1aff83a5cd84b1028c3bc20aa459ccf80096c305e0"
    sha256 cellar: :any,                 big_sur:       "b3ec60b2dd17263f257d8df38caf061091791b695ba191f8574cc4add7b2c86d"
    sha256 cellar: :any,                 catalina:      "9115c375e1db73e80264eed21349a95d8ad6032202a2897d76d4814b6967e202"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5358a75b95ace487baf3e55b70b5f2e48101c84eb228704ca89f9c4b72d1dcc6"
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
