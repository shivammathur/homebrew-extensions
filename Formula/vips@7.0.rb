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
    sha256 cellar: :any,                 arm64_big_sur: "3e35b233e38af740c0cc79f8143a6cd144375acf340fe71f4a4766fd4ad3c21b"
    sha256 cellar: :any,                 big_sur:       "bbc144585eb236fb7d7ce9392d84ea8c8b3a08395c80551b4f2c8763c30dae15"
    sha256 cellar: :any,                 catalina:      "b01c79538752810a23facf6be3341bd8a825bbe455665c00c778e94323292a0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "448426b43b507d77237137ede5911a2babe22959d8e94d61f28053ae780d2807"
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
