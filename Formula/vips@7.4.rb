# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_ventura:  "d07d99391d4d7ce147e72a5c13df3f8d908dd03d20725c50337c6fe6a13f933f"
    sha256 cellar: :any,                 arm64_monterey: "1787ea1d5103deec5c130dc6bcb54e5565f5c888568bd401f18110959d1826a1"
    sha256 cellar: :any,                 arm64_big_sur:  "547105e948fcfd5eef6c6cb50648f21513f40f3e7bfdcc7e758f9f8d73eefeb6"
    sha256 cellar: :any,                 ventura:        "b30e3bb30721b71f17c0923ac040aa806fd8bf4c8710d59bc561b9081a1dad18"
    sha256 cellar: :any,                 monterey:       "9f6a2c8351f924c76ad4b74f4950e04adbc3be2fd6b87faceae39b45d3d818d6"
    sha256 cellar: :any,                 big_sur:        "1b2fcbec91379851d5d70a9c4846b8f619d90322d7ed964a3249a276bc485cec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf8da7a9ecf05d03e0da836e642d895cd955a6b34ff3fa3d40929df19ee18bbe"
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
