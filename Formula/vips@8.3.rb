# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "3e1de6f396ccb45d10c2b74457383ab40eb6e202e302a8cc3ccd00ae37b42245"
    sha256 cellar: :any,                 arm64_big_sur:  "8ab1632acbaa38959dee0b68f606d96a4cdb4eae7205fedb71b9c1aec9908c4b"
    sha256 cellar: :any,                 ventura:        "c4625449a72f8a04dde5ed97e38e8e95e1b36b286ec358cde2544414e2312d10"
    sha256 cellar: :any,                 monterey:       "bf970675a5ff4bdb9414b4d109e632c68b61e30fbcf6e265bf1bafd45b6340fe"
    sha256 cellar: :any,                 big_sur:        "a1c8d03222243ef99068a33dc3c47bd486028e5f7700cfa58e1cc16cee8d8037"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2bf51e143e80625a19a62b1162ca917b60bdda7d403177c94711d97f457e8acd"
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
