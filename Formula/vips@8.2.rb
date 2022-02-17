# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "a4d3a2414e578bbc00ee4558d383837dd593e9e9f4e23f7637f2f8c6405183ca"
    sha256 cellar: :any,                 big_sur:       "49dbdd9630ca5c1cc2812338f9dded599ab2167ce3deae950bce94b331d492e7"
    sha256 cellar: :any,                 catalina:      "d0b57f5327df2a1d25de8d342c6e26c160b2b80b2a78d5f10fe1fd49643eacd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a73ef356df780b0e92108f40606533ca690c0442672e7d805e952618508befe"
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
