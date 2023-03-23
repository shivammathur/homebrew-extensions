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
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "adb5153c3e2a46116b01a6f05df3cc61d4b1fd5512e02712f049ccc51375daf6"
    sha256 cellar: :any,                 arm64_big_sur:  "94e64dd10a0dca296ec5f7cd4d5e114b549500c3fd112778ae1d871554ba25de"
    sha256 cellar: :any,                 monterey:       "cf6b76ada95d0ecda18bf0607b6e015cd7f92edb21ddf461cc4a26fb6d2ffd71"
    sha256 cellar: :any,                 big_sur:        "4eb78ae1507100e76142a177129fbda3544e133804ddfb728ee7c40ae0379f2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0955255a671dff14982738dcd993490f1762a67cfc8cda38699eeebbb61c6469"
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
