# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "221b37642cf4ee950696ba9e4ea899da3bc8eaa657ec7b09e85bba2c2efaa91f"
    sha256 cellar: :any,                 arm64_big_sur:  "69bec5558c15101d100885709fe135f2e15f70eefec83ff8a13e8030e1199a6c"
    sha256 cellar: :any,                 monterey:       "23f1527d669a5b8c4fad5dcc40f59604010d02fd2f19db5edb71d598f62fa8a2"
    sha256 cellar: :any,                 big_sur:        "f0ddd966063d2a8cd07fb5a3be99378d6657d37ae6a77ef5547e192f5aa70e07"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "152e866098e91e6001e0caa1c9ce2b1d072dd263d8b0e9a51d37e55ddf509b10"
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
