# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT70 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "d160645115a519fc95554ffe3acce1d03d42914859f62d4a91a61861cca1e35d"
    sha256 cellar: :any,                 arm64_big_sur:  "a549fd5c1459f9bb47b035393df7f17f597fa3f41d8ab3da545fb18e6067ec31"
    sha256 cellar: :any,                 monterey:       "88bacc4d47a235d905fb632ef3d98f4b16c12e46d4c173eada8b8ae077706024"
    sha256 cellar: :any,                 big_sur:        "f1c197b3a5306108a7e887e3a6ba693d7bb49bcac803b06bf8353a7fa9426ab1"
    sha256 cellar: :any,                 catalina:       "49d4c8c49e05d22569a3dff5465bfceec27abe4d41050756fb5a871fed9bf5fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4451e1c15f930750eeb9c5093d7eeb07287d63180587c70460e91adbe5521c1"
  end

  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
