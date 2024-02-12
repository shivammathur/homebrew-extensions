# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT84 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "c00b32fa5563d78f2853b37adb1d1ce3655795485d4cfff16153494da3411db8"
    sha256 cellar: :any,                 arm64_ventura:  "ad762fdac064e323dd07ce6f5069c465b0db5a0e36a740687700541592f3359b"
    sha256 cellar: :any,                 arm64_monterey: "b587a817260709c7dde47b9936cefaf3adedffe25191d2c24d785318fcb2404f"
    sha256 cellar: :any,                 ventura:        "bd7d6d1eefbcc7bcb3f32eb9d60c98e8a36324d5cd119765fc1325bc20819f89"
    sha256 cellar: :any,                 monterey:       "723d214428af4f94a009f6064a794fb8ee488a601c7ec275ccd2d02d9ba54643"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "360e85cd7d625807abb7fe8baf1944b381c8a337555a500103c9621e59a0b1b5"
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
