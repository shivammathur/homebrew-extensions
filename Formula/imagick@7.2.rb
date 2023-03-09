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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "caa45839fb84cb687a0c22bb48eefb891783bc5ee0d017ee5bc6784caf83b9fb"
    sha256 cellar: :any,                 arm64_big_sur:  "706222e220908362447341c738065f60883b4e3124d7ce106ca8bbb86b9b74a1"
    sha256 cellar: :any,                 monterey:       "98f01cbb737e43d85b0a1ec8ce18ae177da18191aa76dce91f53b4edf12de216"
    sha256 cellar: :any,                 big_sur:        "0ebe574330b00591e10b5e0b2041218717350e607510fc45005cda1855ab90dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "548f98cb360a2ee1e4f49e255221821efcbb812a3e4fa55be3ebc5d195823398"
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
