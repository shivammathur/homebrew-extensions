# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.5.1.tgz"
  sha256 "243ff2094edcacb2ae46ee3a4d9f38a60a4f26a6a71f59023b6198cbed0f7f81"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "b78afd470cb9eac35e4b047a65d4dc5f3ea07e43024c161d28e4bfa0c0d6097a"
    sha256 cellar: :any,                 big_sur:       "810b0fe7dcbd3bcd3ff92c87465fe6c180b83a2bf8fdefb241f21624378a14d2"
    sha256 cellar: :any,                 catalina:      "31414156452d616b4e2d247b85d2a2ab95493cc354986fc5acc63cf0414be299"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9d5468d2a9a9e0396992a6b120a94bd469250f819c8f2cb7150d3c49177c2ceb"
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
