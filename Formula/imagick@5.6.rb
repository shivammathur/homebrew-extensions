# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.5.1.tgz"
  sha256 "243ff2094edcacb2ae46ee3a4d9f38a60a4f26a6a71f59023b6198cbed0f7f81"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "0e3290638cf588b617dddf9baac4e0a0b3ecbd035c207e1df6695f93c461690d"
    sha256                               big_sur:       "8a1db6c1638dafeef5b1c9ab40eafa187f23d00d1a76c283a17e1ab215061ffa"
    sha256                               catalina:      "f30acb2964cd5391a36e5f3362cf07b828238d139cda6fb29fdf72f5a0f55bda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "41c7fcc34c65c042a6c5a4d2f227bb89a23c67a6240c9ae4213e224025a8dfe1"
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
