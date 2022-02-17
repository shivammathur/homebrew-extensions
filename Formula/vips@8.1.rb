# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "21d4a750b19aac44f1e763838252068a4d98b18ffed6ae4bd11b5805c7403b0b"
    sha256 cellar: :any,                 big_sur:       "e93fb6e669b4f21919d9266879773b5d76c7cbf63090a3e6f6dcc5fd208e9485"
    sha256 cellar: :any,                 catalina:      "fc31b1c1d614d8a99db4983149bbd3170ae71845c58a0cbcfee954f3ca5f3cde"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff9a86d80a7c26434d436eb35a6e88aacb78035399948e0618f3ca381c75b049"
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
