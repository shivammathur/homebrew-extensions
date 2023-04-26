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
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "c9d5ca1f605334f789bfef7194600bb47911bbae57558900e24e85612bd484ee"
    sha256 cellar: :any,                 arm64_big_sur:  "970cf272ca9472ca80f99b576abfa6e09b9d098d0ced76b71952b8a1ea1ab5eb"
    sha256 cellar: :any,                 ventura:        "72e9e2401891d78966ca1864bbca0df3ce975fec066b941498ee81a7a01f3f88"
    sha256 cellar: :any,                 monterey:       "e8e942bc4f523fcdcf9ac1b35ca7bda34b8622cd7f890de0f0aac266a446a821"
    sha256 cellar: :any,                 big_sur:        "c2002c9b433737729d7a90f4adc5810512d9e59e965daed00fb41d049b1b4f4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "534f637f19d3ba8e66eeccece248e4bf89694455515cc15e5ba4b2ea20c5b129"
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
