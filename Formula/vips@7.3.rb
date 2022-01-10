# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.12.tgz"
  sha256 "c638250de6cad89d8648bff972af5224316ccb5b5b0a7c9201607709d5385282"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "1a42f6c3593f3264249872236935f91b204c8c7aca2123a5d98590487aac91a3"
    sha256 cellar: :any,                 big_sur:       "57df17aa5aafd08fdc89fc5f072f6598171f13fa4c8fa6438d41962fe032f5c7"
    sha256 cellar: :any,                 catalina:      "9acdc0f73d860abed5e58746cd7d647e3b515b3a4803ea8f4850d28fde556e91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3a500a9cf32a4cb78a137f2d8eae7dfba7cf2085c02bc683ddf09f2189857424"
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
