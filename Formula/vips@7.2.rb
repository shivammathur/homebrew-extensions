# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT72 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "d9d5bf67535e0182f974151ca13c3a707d5390a1c26212e5cd0ff06ed6b97d88"
    sha256 cellar: :any,                 arm64_big_sur:  "7526f550e7235dbc9147568ef135f18a1d53b32c1449ba1eaf455db9f2a4a5d7"
    sha256 cellar: :any,                 monterey:       "d4e79a46c207b47032bdc0183465ab070a7ab8987ef8ae3db4bc1bc865198229"
    sha256 cellar: :any,                 big_sur:        "04a267c54bec9deedf8af67ba0956ed6e59198bb76c53a82b69297ca53a35abe"
    sha256 cellar: :any,                 catalina:       "7d95297e7140961317e0e4c5f814dc3d2ca62f56219080fff22226c7365d1ff5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c086a59141dcdef55f52231bdda615ba08ba24847e41524f5d18d8536f6f4b7a"
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
