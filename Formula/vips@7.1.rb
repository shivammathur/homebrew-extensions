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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "62be9579c0b50cbc43b3fec2954f573c554885e3ee7580ac2021691e59453569"
    sha256 cellar: :any,                 big_sur:       "5f2a565619b8d5f23bc229d76aef4e149a7d896f3ab484bbe0e3db1214641ece"
    sha256 cellar: :any,                 catalina:      "1ba5218fa8aea3fa47c98a0ce2e4f1d9cf764f7b8eb6b6d71c7234cf4d2382c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f8a8f2d3882d592c97d6c973f1826b6febdda24e581adf9ce419f15d77609b2c"
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
