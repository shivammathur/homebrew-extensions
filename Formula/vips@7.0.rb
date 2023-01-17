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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "2a9b2b24ab4047f80a64eab1936092a1e4fe69c444fc39071cdad8802b20cbd3"
    sha256 cellar: :any,                 arm64_big_sur:  "d2926d4d2c162cfc3c3462867de1da8f609e4658c7df8beaaf50d53666ad240d"
    sha256 cellar: :any,                 monterey:       "71e8d685e84f48dcf8d7ebf5f046ca6b8dcb80632ebcb03b8c0d90208b643221"
    sha256 cellar: :any,                 big_sur:        "dd7ab1b8f82cbec365e0ba8b1c31b80f7e69c50380d2410364fde1267ddf4627"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "37719e6445b2b82fde08a59ea2bf285a13b645b4e7292fd4cbe9312010c0efe6"
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
