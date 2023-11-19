# typed: true
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
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "b1077068919cc46c5d4f8c550695f7dba33d084e5848c6aca72cdda30f67f6cc"
    sha256 cellar: :any,                 arm64_ventura:  "bd2843a2dcff6a26a19ed01f8505bdbed9b77eb6a03558afa34a006298723b9e"
    sha256 cellar: :any,                 arm64_monterey: "72da33c5f46f2383e75c136a118a3494eaab29ca18c4ac0631d86c1ce1674b83"
    sha256 cellar: :any,                 ventura:        "160d3aed8d4e42014e5df7b3853c2690a09cad80a189435c45ea28ce3e9ad9ef"
    sha256 cellar: :any,                 monterey:       "7d79bc98d2dc62b009ba3fc1be6967cfa24c480e522ad1984ed0fd89ad5fbc75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ec1229d077e26cd3ab09471d421d54399b796a05060ba4c7002599b8d1c7dfc0"
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
