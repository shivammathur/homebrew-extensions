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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "038d3fb4395b29a5cea93aa3de1ced73dbb5967dcdd79ff5b166de0b6149fb25"
    sha256 cellar: :any,                 big_sur:       "81ca5cd6bd100fe6c082a1ffcaa391a13141ea0235755e9bbd944952dcdf6aba"
    sha256 cellar: :any,                 catalina:      "bd79ddbd3bbba42a0d49c98f2e8ec4d96d9246620f75e0c77a76063823eb01a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62397f4adc28be409981a36db623801c60d99cbe860d1510aa65900b7e391319"
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
