# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "061f7994ccfbdb3afba35d505e10368508a010bcd2997769aa26b0b5948bf15c"
    sha256 cellar: :any,                 big_sur:       "bf84bd5f2d8147168236715b39d17b577c40c291cd37e5792528f92daa5fed30"
    sha256 cellar: :any,                 catalina:      "cf89bdf6e29e65d6917668b9618a6b0b24fa1a76e6260c9e365da371e772f628"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "13a8ac79b3605cf8790b6c2c757d639ad65d7ea643ca9dcc8b4ca9abfd4f3975"
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
