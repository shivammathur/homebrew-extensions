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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "47e15c8349d9e192ac0d4243b02ec1bcd984548592e694f7fb7290efc343955e"
    sha256 cellar: :any,                 arm64_big_sur:  "c361dca9479966e682976c39e8242a681055323f82368652ef047b8028a90730"
    sha256 cellar: :any,                 monterey:       "8b00758ae8d8238714b66fcbcbd3894c29ba4a8a2e6a0149a042e7dcc61f4dcc"
    sha256 cellar: :any,                 big_sur:        "24d7d63254138e623e155ae106df6b6bbb5807aaa485257246c54a58284b3901"
    sha256 cellar: :any,                 catalina:       "e79425773cc104ded9e2fca18b1eb8469206bca6bd21a7e4336872df804dfaa9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "578a3b89db5d02794ec6791985e9b1a671a87ab0a180109535ec664bfe0f25f2"
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
