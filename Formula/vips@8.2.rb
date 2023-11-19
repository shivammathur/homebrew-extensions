# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "a98c9d628d553f73803d3cbec039af58546aa668877fa77064fa490f9ef1dbbd"
    sha256 cellar: :any,                 arm64_ventura:  "97481ce98b52d8186a6bded540b189affe7e51c94d5a0a0040be59d0165baa62"
    sha256 cellar: :any,                 arm64_monterey: "c66f937b454070902101481c1c79b80dcf10943efe8424a9e8693fe7d2f61e28"
    sha256 cellar: :any,                 ventura:        "c287c941512bb42aa88082b2d8c7931d7bd275415e874567677668076f9860c9"
    sha256 cellar: :any,                 monterey:       "d8e69d5db457421589ccfcfcab1800dafeb75c0ba22ecf54acdd24e218edd1b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "70710265dc003d019afd1fa99b948d0ce6e146f636802d07d2a646ca7a2d1de4"
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
