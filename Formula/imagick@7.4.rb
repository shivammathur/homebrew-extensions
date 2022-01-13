# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "40c56931d5ac2e813be3d4ae4a769f28b530ff0b6adad778ffa9338576c4ee0f"
    sha256 cellar: :any,                 big_sur:       "95e820159b09c23aa9d25bf60e2b151677d00d43c2f48adc2dd563bfe674b927"
    sha256 cellar: :any,                 catalina:      "3797168aaf4044105de164a284cb675d35b1b73e584013c39bac35c5d85784fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a95907edbef5902f46fad2248c20ddf064f9de6b560a01428ae58273de6e5cac"
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
