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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "1fcf8deb21512ae02613728f36c3e2854d54750b957ed17537fca5c623f8702e"
    sha256 cellar: :any,                 arm64_big_sur:  "59e2fbc963bbe3554d215200b39914072f2551b7136f9150e187a17f1284c5a5"
    sha256 cellar: :any,                 monterey:       "bc4bfd767d42566e3cabce1d7331649ff804ef47c41bcd5a3b76c2996de4ec95"
    sha256 cellar: :any,                 big_sur:        "f029f0aad7b7a305a9b16d921d3ba3a38d4acdd08fce5e3ae10208610d5ee343"
    sha256 cellar: :any,                 catalina:       "01e20bea94ca08bf3d428c6ad0cf48faa74d9941ed31f45f06a43738d6f927b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "432422898882a3a6fb38d5a55bde1a515978825e004084e8d488234f368d6263"
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
