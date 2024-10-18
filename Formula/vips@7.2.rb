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
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "0663be9a4ad7715b5bebd543d3574db3e6f533d8d61ead1811213826105e24e1"
    sha256 cellar: :any,                 arm64_sonoma:  "1a90aa6c38bcde2535e4aeac9eeb11bf42d5b5c01e4e152361f6565d42cfc017"
    sha256 cellar: :any,                 arm64_ventura: "c097ecaab2ac447e88af156925ca7420d67a8962fadc92af1fb26d9726e02ea3"
    sha256 cellar: :any,                 ventura:       "b6493d5ee4bb93ece5fa6ca609fa721656545072aadb05529446753b2d427704"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2bd07da9c6504f85438d4dc7b4e5bc3aaec7b3f9275a63f6d2ff81f58256efad"
  end

  depends_on "gettext"
  depends_on "glib"
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
