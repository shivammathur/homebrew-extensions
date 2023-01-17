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
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/imagick@7.1-3.7.0"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "13880fed00edce170e5d69408f40b4e14a1d86090708e625a0ffcf3ad289ff79"
    sha256 cellar: :any,                 arm64_big_sur:  "4def1a5a3373c669bf5bd2bf7579503516b585a35e2a19e32ab73ef2c54dad87"
    sha256 cellar: :any,                 monterey:       "1dd3e29ca90b8561e4a5f8b959fb222c5157f33b7d24d0f589bb8bec33ecb7f6"
    sha256 cellar: :any,                 big_sur:        "9565c7e2e4b1a8ac7e53cd3d2532ae2c2dd113df1a81270dc1c37e9b9b7addc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "829644413673426e981e2f8df424326f931e46afa93dc1474734e1721529aacb"
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
