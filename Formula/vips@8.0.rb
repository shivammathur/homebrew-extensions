# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "9f37b85ab75fba8f5f91367dad1fbfd2f6573df64d2ec0d4d04d6b3ecf336578"
    sha256 cellar: :any,                 big_sur:       "4725309f1a1d57e0da62c6e799328d005a18378b85463c4f68b973ab3995de79"
    sha256 cellar: :any,                 catalina:      "2525984bb36902f39e384ba3998c9a0e2baf7158a97bea2d98c004bbd5ab3960"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9c13e36ea6b7b30e75158702660cccb1e51f17f8b2666dba68edcd646dc1abda"
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
