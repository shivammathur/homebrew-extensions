# typed: true
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
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "944fdaca94802afa92c5bf2044208a45f6f254a53243e11306fdc97655d547b7"
    sha256 cellar: :any,                 arm64_ventura:  "518c439f8f2bfc183c34e6d28de287a181d9c3967f8afa5cde93785e71809e0f"
    sha256 cellar: :any,                 arm64_monterey: "d26157e2806bcc5e34bba0efacd1578d4a84f08bfe9a7a92f5f6c08fa939a375"
    sha256 cellar: :any,                 ventura:        "3688c724e2ca4203eceb89ed73afd0e30d342eeca8229aea80cb31b09b574a9f"
    sha256 cellar: :any,                 monterey:       "0ff32452981c692f6c046a3351bc9e1155160308d4fd7034f33d33bd2a729db2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aac27a977181ad8ca7af080ab9bf147a738dc0df73795430ed3e4dddffcc6d8c"
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
