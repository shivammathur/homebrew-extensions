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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "c7bd5a202d5fa862b33338d12eef3135141a4eecc040a50ec1962f13770e084f"
    sha256 cellar: :any,                 arm64_big_sur:  "50565bdefd1ef63b33def0c7ca03dc7042e75583b9fad8c8cfc0178765bb532b"
    sha256 cellar: :any,                 monterey:       "f0d6a909b114fd82d35a912033c4892dd8652e26ccfe89b8b570e7c43aa76c46"
    sha256 cellar: :any,                 big_sur:        "56c74b3e4d5ab0a201a4db550c7107a6331a3905473a16a61da3ed2c712971d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "758b187842cb8131112a13004c89c2cfc5444545ff7986b36c47931ae8e6c478"
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
