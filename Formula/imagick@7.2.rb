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
    sha256 cellar: :any,                 arm64_big_sur: "e36b1ca4b1574f461d853ea2663270c9263575f4a89b7b98215b6f70ab3be415"
    sha256 cellar: :any,                 big_sur:       "e8063e7ede8b4aeb29397351b05866c45851e44c6695c6d6c88935dee9501e08"
    sha256 cellar: :any,                 catalina:      "d4f834091840367ed7b20fd8c4adcc1dea1c02c3730b3768b37107255aaeb1c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e8b7d4ba65d54a8420636de3a16b680dce759d91f20b25f81dad453bbeaa0d4e"
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
