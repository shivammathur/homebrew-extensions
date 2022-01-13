# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "51fc39d8a81a70eb32772a5c0d6b7c17c96becdd72698e4aa82a69cd0ab6dd4e"
    sha256 cellar: :any,                 big_sur:       "938661dfc2564491e9c70f25abe8f0983af5efacc9dbfd1d182d021feb508af2"
    sha256 cellar: :any,                 catalina:      "ed54b0b01e448ab7861c1292f4c22fb47997eb8bc8030f624b9ce12dbeeadb05"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d9047418e7e5b82a1d1f1a4c9d4e4d35a7c6e9fcb352fe3b073a5b7b98c0f0fb"
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
