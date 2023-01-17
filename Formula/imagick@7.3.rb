# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "dbb41412b744fee3d2575a25180e370fa1071d4965641f353f31d0c2e5260ecd"
    sha256 cellar: :any,                 arm64_big_sur:  "c65d9c83bb6518358b99f340d430dcb529b50dcd03e8df2f624149e40e6a11ec"
    sha256 cellar: :any,                 monterey:       "1f12202636f1615ae9a1981149e8df2a210ac1ead79efbfefd7dc1fa0e9947c1"
    sha256 cellar: :any,                 big_sur:        "6e8d2d20a9d62a6d67562721582eb614e300f0f06de0bc24c4d92dda6b2cef9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5a3395135c4f296791710cd0948569ad259470f73750a0226c5f26494582fde"
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
