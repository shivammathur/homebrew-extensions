# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "d5be2088d771fbabf7c895483590251bd6eca9461bed43f7da2e9c0a43279f77"
    sha256 cellar: :any,                 big_sur:       "b42e5b29270f8105b0b241ed83fd292c407341f8453a7b1a3800b564a4aabd6f"
    sha256 cellar: :any,                 catalina:      "abc07c6c34f9de67bd0e7338a9ee5b2924164adaed8cca434302d733e914f7da"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7db73af35dc82a3dfa009897b493b055134d162f06b9d9c703a223e26630152f"
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
