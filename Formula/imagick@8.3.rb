# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "aa17c6faa98fe66e1df9763841fc10e8e0c87f5974086c992f23660291d5e485"
    sha256 cellar: :any,                 arm64_big_sur:  "8f32e91b09750c5cf997983396b25274d0e727885e18b284ad2acd40ae3d59b3"
    sha256 cellar: :any,                 ventura:        "e8c36a64a4495ef1f143d8cd6ccb4d8a3528f95d491797aad714fb8fbe7c1c77"
    sha256 cellar: :any,                 monterey:       "bcfcaf25f077a499947998fba73936401710dc2e1543bb7d66dedd79cd56ad10"
    sha256 cellar: :any,                 big_sur:        "53d57a6fe468dce0fb63cbe3fe3b92f82bf113ea3d763b2c7ec411480a3a5615"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "830e9da2dd477f8d7ce2ce44cce15c859d29b704fde65270d4afd839ff2c60b2"
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
