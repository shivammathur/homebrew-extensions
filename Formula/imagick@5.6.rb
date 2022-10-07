# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a112b75f577de345595d625cecb42e30984965a2fb6c0fb4224efe96185cc89a"
    sha256 cellar: :any,                 arm64_big_sur:  "ae0127410ab83b9b16a937c04289deb1819357a6931bb2f5cdab1925af67e9f4"
    sha256 cellar: :any,                 monterey:       "bc0d7af89e16ca4ba5e015773c0370f2fd291bfd49dc94369e3f59e14b27c2a4"
    sha256 cellar: :any,                 big_sur:        "40266300872a73d1e989287f05647cde1200e06007d076e7eecfb68e55f1fd9e"
    sha256 cellar: :any,                 catalina:       "0cfcc9e297f57b1df28c29ace8caa6fe91123d3883bc89174e0df857916d609c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cdb79b47dfdbd650495a5818da5334ed4a74b81446a672c210b99887d6ac584d"
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
