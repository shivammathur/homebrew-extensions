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
    rebuild 7
    sha256 cellar: :any,                 arm64_ventura:  "91c3349396565107609c0384fbf2176dfaf9af7f23534ec546d974fe64c01122"
    sha256 cellar: :any,                 arm64_monterey: "0fbdb1ee64f7eb8c9de7c111d449c5191d6cd5c72657f8818bf131ebf2f91363"
    sha256 cellar: :any,                 arm64_big_sur:  "fa1c3c1ed758f2d51dae96f15d10a4a5e6b5c698371709f24c31ee6d108e33c8"
    sha256 cellar: :any,                 ventura:        "2b5e69762578332e23eacbd3efd6e29c016c6ed0124fda787bca01c16d92cca3"
    sha256 cellar: :any,                 monterey:       "a7bd09eb0bc35a294f0a5a40308d6ec89ceba88dc27d896e1df6f7dba0f0f867"
    sha256 cellar: :any,                 big_sur:        "a27b14f10b92ee45e87cca6d228e04a56105225778bfe15b8259dad5223cc9c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eab53fd310ee453031053bb8af6556c2a2224c9a35e398d1cbe59349db2fe460"
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
