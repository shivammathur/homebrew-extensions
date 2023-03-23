# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "ae362a31f16e185b1b87990632454da2be5108b44f8dfe5505e5efad61621610"
    sha256 cellar: :any,                 arm64_big_sur:  "cf16e7c62332454cd79f9add78ea047eafd7d82482fe600da7040b2bbc1856a8"
    sha256 cellar: :any,                 monterey:       "2bfb56c5c51abaaea9c71449ba30e93e3a3db0cf828dbea426f597614fafa060"
    sha256 cellar: :any,                 big_sur:        "fd48bacd5ca7d6c5105da4dbf3d23515fa9fd350d98218a5a16d4bec43de47c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "00741c8dae49cae7d2721801d0aa0ea46603c0c0c24f9f96dee5b71f15dd839f"
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
