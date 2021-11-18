# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "9fcf5e64aee662e861bd87421296936c386b7de4e7cace37ba097715585fc157"
    sha256 cellar: :any,                 big_sur:       "1067d719f79a585bf28f908d220db8c492bf27e25716a4e47f4efd28f678ac96"
    sha256 cellar: :any,                 catalina:      "9631a853cd5e0519b46b996d5139973987c108865d2d8eb539cedc1af26a54b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f83ff5c96fc3aff18a16482cfbbf8dc2ad68d69b5abb6ff55e7e4cff87e69da3"
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
