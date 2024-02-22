# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sonoma:   "bcef21e3c247663d919bcc3d2528b7906554c84f160fe203fbc953880098dab5"
    sha256 cellar: :any,                 arm64_ventura:  "b0144168db4e60be6ad903ea488a07efa682e0037d7348499406f992d4d4333d"
    sha256 cellar: :any,                 arm64_monterey: "6fdc09cb38de5903a556b8a53312a893514f33d905c03c410724c328b040b483"
    sha256 cellar: :any,                 ventura:        "1626ad003d897ac41bdbf286c8f08741593c6b7da485567cf60ff517c0f268a6"
    sha256 cellar: :any,                 monterey:       "830bf19be20210a760a941163c38badc4d1879f9fc14c7deb12f91940ad66728"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "43aebb22b4854a750d8f189aa3481d4de3b5fec929a177b31de021375dba94ef"
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
