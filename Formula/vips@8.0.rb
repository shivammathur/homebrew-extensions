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
    rebuild 6
    sha256 cellar: :any,                 arm64_ventura:  "a422c488121fbbc95a1f03f8c9534b0d452811461c6234c67b92eb0679e77768"
    sha256 cellar: :any,                 arm64_monterey: "ea6b76b83a8402eb0988f2847f5f7f3cd5c9a33e194afb543eb70e44e691ee0f"
    sha256 cellar: :any,                 arm64_big_sur:  "08fab4a17021b3b68f6e41c7a26e7a3e99c4e721147f300102ab2cd806cc2975"
    sha256 cellar: :any,                 ventura:        "317e39aa51060868d3a49c864a74fa994ac0f863d2abf04c734de9cd8c3c2d72"
    sha256 cellar: :any,                 monterey:       "6fb75ea2d77210d2771f46cde6e210a4ab92b24dd248b3497b1a888a9a09c70b"
    sha256 cellar: :any,                 big_sur:        "4a2356299778c937b6e63ed5d51f799c46654b59de93ab11a5328d7652c3e114"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7962a5fb39d5c2c69c48c44a6c0e2cfe96c2f32e17f6d974267eda7d6b865b59"
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
