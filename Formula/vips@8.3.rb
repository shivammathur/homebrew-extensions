# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "97f0c45535520102e2b9b02ca530831b84eb91a65b596523d22c39ba3b174cb0"
    sha256 cellar: :any,                 arm64_big_sur:  "8077cddd3ba442f45d9873fa75e1f4596b2dd29f33179ab8e05b8647fc604042"
    sha256 cellar: :any,                 monterey:       "9f6417a7da13d6d7f10970e0ab0b343029d7f8561b098b3ea97aa6454b1bf7a9"
    sha256 cellar: :any,                 big_sur:        "7dbb332d1ee89824cf94e49347a497498e4fd0a6570d09bd1df9bce43ced088c"
    sha256 cellar: :any,                 catalina:       "27bc62b54e82841642d8bc82fe849c1c40ee07c77214560e97e714818a74674c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f62bd3335326a1c3e706acdabc05f513d755a3bdb01b1c447fcb4856d694a1a"
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
