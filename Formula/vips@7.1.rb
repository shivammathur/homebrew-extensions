# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT71 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "28a2a6d3d81203916fcf96306e7dab548e53db1a34e1b5eb3873ee870f313680"
    sha256 cellar: :any,                 arm64_big_sur:  "acc576f15f86f703d66d17391bad77fc202927bc65a66b57303a5c682a385cd7"
    sha256 cellar: :any,                 monterey:       "7519ba8862154ff005c4b3997de564f46c1668487c7b39886445889640ab17a6"
    sha256 cellar: :any,                 big_sur:        "c6bb22994f495f4c3174bed1bdbf0e48a0dee23ccbb049f0a87f3ee4a402ad3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b1d69b37afb660e5691f9f29acf7fbba572060ce54fb7b535c1492fb8bb314b"
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
