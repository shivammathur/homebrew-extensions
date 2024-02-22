# typed: true
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
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "4b6212009406e0c0d52d41fc1433aebc7d4de86c8069fa1eb2e7d417aa4fd3e9"
    sha256 cellar: :any,                 arm64_ventura:  "da51856fd88eafd09f1060e5fd830bed63e6eaad2b5c704ed349c5a51a447c1e"
    sha256 cellar: :any,                 arm64_monterey: "c0551cfa03f20ec25464f15eb5a5a5bbb42a2df684a6a54326a8e2650c80e5ff"
    sha256 cellar: :any,                 ventura:        "106689450f65e7fb3715b4152d208267537d3cd743f8e8ad725df736cdfae154"
    sha256 cellar: :any,                 monterey:       "a162bf66754b7b8a70ddd496b7cc9b7a607f13a24cff6ffd6a620a1e2a2f0c92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5e0db40f2ab5011045601d5a4ec0daff36ea1559e1e3a8b82a11ded8bba523d"
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
