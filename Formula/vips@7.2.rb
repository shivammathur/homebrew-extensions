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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "fadf7b4c7dd81413af185acd934dfd3b973c695628b4d50df92b533fb69af185"
    sha256 cellar: :any,                 arm64_big_sur:  "ced1911e5b563390a7c7071eb7a17130dd388806f8f487a4be654bc4363c8585"
    sha256 cellar: :any,                 monterey:       "dbbf9d4f0a5150ba7ed1eaf9e27f243a45bf06ce5f0ca2f9d4ec37d57364234c"
    sha256 cellar: :any,                 big_sur:        "a0002f09242a9975097db3043113a4a4ed8c5cb57a11259aa8236490f052d203"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6a7ec8a599358b15bdf7e47b6e9ddcaa1962e22adbafad3a1dcf2c583d6525d"
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
