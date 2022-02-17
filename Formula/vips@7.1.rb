# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT71 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "bfd11fae72526f68d8dd1d80a32e24df91e5e7327beb78a080c896f9ca34ee66"
    sha256 cellar: :any,                 big_sur:       "94855fb47ecbe01a807dfb6292dbe76a9a42d4e97f50975a464ba87f6cb2c322"
    sha256 cellar: :any,                 catalina:      "4a4edf79d234f9492a63cc4b06dbe96c3e3f5fb3e92a9df34b58fa3b2628e83c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "25aaaf0bfe45c6fb0f1bc955efdfbdcf276fe8cf4d3b12bd752218760ee6b51a"
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
