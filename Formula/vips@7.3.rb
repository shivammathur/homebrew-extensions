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
    rebuild 6
    sha256 cellar: :any,                 arm64_ventura:  "764a8a14f8e68c527166f9457735ef35b26afbdf37a0be44b769a1a247fff666"
    sha256 cellar: :any,                 arm64_monterey: "57b768e85801306f93f05afbfc0d90e8566897541c2865b10eaa6ea21a8d81fa"
    sha256 cellar: :any,                 arm64_big_sur:  "f362e3dd5e49dedc41afae9813dbd595d541aff3b8731639e9dac243827338d3"
    sha256 cellar: :any,                 ventura:        "8575f6d49196b24016e9e62ef7b1c3ae2e4b7403395050c16ea850077484a714"
    sha256 cellar: :any,                 monterey:       "b046a280401286a2835bd96531898d49c27e3ff694f27ec227904b567ab67f05"
    sha256 cellar: :any,                 big_sur:        "bdcf6d65d085fa89c90ff99e2061b0a888d463035111972fba6da3535b887f41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1726dc1c32fcdd95899e768f195d85487c4fab17be81afc1d89680eb1b040729"
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
