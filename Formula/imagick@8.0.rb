# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "348a73e2c51e23c3183a96f558e4c4c8a9e7a16e48d36492c41cf35b93a59fa5"
    sha256 cellar: :any,                 big_sur:       "239789eeb019e8673f0c2d555c61434cdb3dc68e3ec0e368eda12e6765521a9e"
    sha256 cellar: :any,                 catalina:      "11e5eee8361054eefa77bada7dd3f278919cede59eb94bb78b24acd842d15ee6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c76371126d5b60a36ce9b4d86fc8090b5e26aa2c01393957eb4b7313867f732f"
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
