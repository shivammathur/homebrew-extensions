# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "153abb414136ec53aef1b297a67717d612c49372c2f4eee52b3dd01c7da48723"
    sha256 cellar: :any,                 big_sur:       "1aff06e48426a80976eac5a6a3074cb7b83f99f0eb0346c9a0f087f58844f5f3"
    sha256 cellar: :any,                 catalina:      "0a232fc100cc572d582b2c33540eba70c0c15bd6d5515e7a83e5d68f5d713db6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f43f2b12ae38da9a61b19c50f006a569f8d5c500ea29cf58b5200ef3db1eb031"
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
