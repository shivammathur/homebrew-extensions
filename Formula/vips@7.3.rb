# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "6500f79c086691e64717deecc7943d6acd56f55fdebf1d01300d51415e0e0749"
    sha256 cellar: :any,                 arm64_big_sur:  "f02cefab44944976659e7b327d19bdd5912bf24231564caecea0db808036d52e"
    sha256 cellar: :any,                 monterey:       "ff4622b27110042e28c7c67f1ff7a128c18538ec9a1dc0459f560cdf4318a4d4"
    sha256 cellar: :any,                 big_sur:        "12dccf84c1a97427f9c5d91a2acf39e1825989f5086791448f49f64289f616ae"
    sha256 cellar: :any,                 catalina:       "395909507fa4a00d45c7f4adb906c2835ad95ce58460adbc464ec9156f760e8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b62987ef9f25212f45c32b4674c114d8e42cfa582a9ca1d5666340519671f63"
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
