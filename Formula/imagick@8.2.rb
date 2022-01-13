# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "e45ca043727c1cb5ee8b7203e32b35d2adbee9c705fd3c1769a3aeaeb52cd67c"
    sha256 cellar: :any,                 big_sur:       "4911047daf4e58d6b82323a2e2bf24b37b9f48f7bdfa7994eceef4e9328424f3"
    sha256 cellar: :any,                 catalina:      "e5d295bf17f15805e97df568efbb7e19e840b06c69780cc4e4892ee167052f05"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30df8a4fb0bf6035bc0019084830eec7aae3b0b34daeac1f0d2bb0d0d5f3b4e8"
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
