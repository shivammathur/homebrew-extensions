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
    sha256 cellar: :any,                 arm64_big_sur: "59b66e1c47506b54c0fd6212257198f95efdf149891c4d53cfd946efd4be97fe"
    sha256 cellar: :any,                 big_sur:       "b704b823e62b179602165fe3ed631a8cc24e12c84588d02e83ce4b666fd66173"
    sha256 cellar: :any,                 catalina:      "1ee2d6bc27e75035e17c15a82a3717876b60deec83dd5b25bfc6d5210f2840dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7810b4481868a4e8e7f866c2cce666251e09555d6d73ced91e61adcb6413d052"
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
