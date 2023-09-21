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
    rebuild 7
    sha256 cellar: :any,                 arm64_ventura:  "0f8e9eff7c06927bc72acddcfc6d1a101011c13d366b2aeb05ea1bb80e8b4fd3"
    sha256 cellar: :any,                 arm64_monterey: "24279067f6dac83b326e9f2c29a9f96647fb3f45d939b47e48e6dfd129d8d3f4"
    sha256 cellar: :any,                 arm64_big_sur:  "9c1311fb155feffcfcf7e20d6a4a350a487cef2e9c5e07952c81d8dd82d45c98"
    sha256 cellar: :any,                 ventura:        "1c80ec476c435003d5b8f00a4b89a4d803aa6550b0010509029f7384cfc1b461"
    sha256 cellar: :any,                 monterey:       "f1624b3dfef3db820abbfa57880322e9b8b8c54260c919dafa3789d26e607e96"
    sha256 cellar: :any,                 big_sur:        "e0221feb6e39af682862a88eb006ec66675de8e0dae95b5ce1eb33e03214b8d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5e8dd8efeac9ca1efb625edbcc34c0173ecef92a93db1532cba9e90be38ff78a"
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
