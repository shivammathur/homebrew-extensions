# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT80 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "8ad3bbc40b83487904caa65f90d9a4820f5e015da094f4cbf7032ed48926f83d"
    sha256 cellar: :any,                 big_sur:       "50fe743d15a9d94d90d5a294fbaef4be81eee7d341812ffd5917b21a092c8eb5"
    sha256 cellar: :any,                 catalina:      "7db82fb6d644d8f386aed6608d960a7dbb8c110adf684be3840af3318d8bb267"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2e4f924177488a0ab0895e03514dfb7cdbffd02b3f74baa9748f22d0e97355b3"
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
