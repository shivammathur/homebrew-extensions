# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "bdb44b21481fb6f8dbf2e141f4f62dc5fc825bc48faa77bfc925da63625898e6"
    sha256 cellar: :any,                 arm64_big_sur:  "2b31072798b8ba86305bf1ca31f6afc8c0ad6f600aee2e248188f8a9d5f1a661"
    sha256 cellar: :any,                 ventura:        "6f6a210ae96ea7137109bab07ba198b9d930589388f829a9fbdefc7fca5b5e2e"
    sha256 cellar: :any,                 monterey:       "fcb6b1ce58c66484af7653f69c9bddfce2052c756e64028941b2c78af4c38de6"
    sha256 cellar: :any,                 big_sur:        "fcb10688a237c4e2838b33ba28330abbcd29deff184291e70c8b88072dd05f49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "074c28b573bb62f45b1bd60bedfc7be18a9cea4d5532463a5d4695c8f5ae565e"
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
