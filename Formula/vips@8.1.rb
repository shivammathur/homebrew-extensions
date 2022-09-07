# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT81 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "9d11e4f0489bba9331439858585a78091168726b97324b8f0010d7dda5ae77b7"
    sha256 cellar: :any,                 arm64_big_sur:  "2009d61c96242428b0fa4df83a2e55792d47b50877159c83dac1f4b99ed8a46c"
    sha256 cellar: :any,                 monterey:       "00323db1e39f607a3c741679ddd7a7485ba7df29e663dd942dde73e1cbde2d08"
    sha256 cellar: :any,                 big_sur:        "839f124bfcfa074dd8196ee8b24ec9b79573c427d906e516f3352b366546e149"
    sha256 cellar: :any,                 catalina:       "f9ec14d1d9e30f056c51e1669b67854914bb8693207dc302b8cb90113ab7fbb8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3522e15d8d937d006430dcc2853685e1f3c09e9fc8afc50341c94441469cdb39"
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
