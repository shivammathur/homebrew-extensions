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
    rebuild 6
    sha256 cellar: :any,                 arm64_ventura:  "b591ad930c8eac3e620e033e6a8525738e7ca5d148b291422895d24c9adef664"
    sha256 cellar: :any,                 arm64_monterey: "ae3a93c1368d1bf95b099fac88d00a546a7b17d67992af9b9084cfb304eb1b5d"
    sha256 cellar: :any,                 arm64_big_sur:  "9ff1544bde5a1d8ea026e4e20ed36889648d2dd0f954ed0cdbb9d63dad0d292f"
    sha256 cellar: :any,                 ventura:        "d8c77716d50fbd871ce9460b24dbe5bd6fdcc3b7ff0e02acdd07c30ddfd852f2"
    sha256 cellar: :any,                 monterey:       "168759fc195a21cab3903f3ea4f8a7a0a3f00f535a265d0665013b1a3a15998f"
    sha256 cellar: :any,                 big_sur:        "212b8348c3c28f44f9e8418422fb0a1712a0ad2faaf77892f880fce0f0794987"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "922d1c7080d5572fd5f31f3edcf3d79fa0de76bbb8d6ace6cf6e5919cd9afc65"
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
