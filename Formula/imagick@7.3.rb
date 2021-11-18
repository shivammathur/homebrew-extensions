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
    sha256                               arm64_big_sur: "633bc2b572d28341c713b5a022d0e2c6f99d76f91b8d713423999a9a97812535"
    sha256                               big_sur:       "03914df3641517ce1669ce1d34c6587738b6213914728eb25cebef329b1efd3f"
    sha256                               catalina:      "a471be4ad5a74a964572adf1bd18c35e8fdd81598c513b2ce8ec5cf9f7f050f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c772b1a2de86c1160d3a20393330041e527186914c9766d0f77153cc4fc88770"
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
