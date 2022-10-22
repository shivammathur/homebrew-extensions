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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "b9ad910267fd0739cae651cc38f0596547a5213555e1c405affbf54b71ebd2a2"
    sha256 cellar: :any,                 arm64_big_sur:  "58f4689599a324df2860f9cc93cdea7c1d5907a0114583f489e5cab9ffad372a"
    sha256 cellar: :any,                 monterey:       "1e5320f7e081d27966b5c7a9e491a4391e4de7dc096d3880938c5323172ede30"
    sha256 cellar: :any,                 big_sur:        "f9bb9b23fb3348fb11c5dc025938a098501a0a8a3d46026f5346a4a1c99660d8"
    sha256 cellar: :any,                 catalina:       "1ccc27e5a2a0c9f61389cc4cfcb9a3c3a994c9e7246d4f27f645ab3b0d9333b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38151744ad14784a129be4d61c43db34487b265c23a9fcedb0eca3851280785f"
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
