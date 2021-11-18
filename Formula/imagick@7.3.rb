# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "bf1b95379d11fd50025e4e0aa63dd1aa0ecba4c82524038f80c3451b72f2555a"
    sha256 cellar: :any,                 big_sur:       "f2b37374c2d7b44e7869c26c6bd040562ae4821f0f5c724c8a27947879b3edee"
    sha256 cellar: :any,                 catalina:      "319e6d047fd72fcbf888474855eafbcc818a51ce58d650f738bd1b17640f1e9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e74c8ceab1dc560fa083bcb133d9b45cff030264d708497e543e336752c0896"
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
