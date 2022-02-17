# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "dcbc2086ebebcdc3f16ec8911ed2c78ae833d6322237c578a720477954083e0c"
    sha256 cellar: :any,                 big_sur:       "0c30a0ed539d62744f3968195f325b061f33ab4fc7dd02ffe2ae87455f962da5"
    sha256 cellar: :any,                 catalina:      "3130d93fb580139d309fa2d53523f23e3ac9309029bf16665ba406d8ab25122b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "659c1443872ce35105f3ccb146ba1a1164286b2690087609ca1d0de6d5a78cc6"
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
