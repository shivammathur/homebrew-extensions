# typed: false
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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "fb160fff0d4f4055731733eeb220f3314a584bd3931e42a7ea25d5b82d3dd943"
    sha256 cellar: :any,                 big_sur:       "effb1a9838dc90443bf96cfe08ffa80d49d32558f97f201aa7ca084c031cd9e0"
    sha256 cellar: :any,                 catalina:      "313dd4dd39c2c227013d3daa5917989513c32d8125b01654caa04fdd32bbe6b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6243a0489bb431a59ac29e30ae11e1c490d1a105fc0e251237f6d0e73205c5cb"
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
