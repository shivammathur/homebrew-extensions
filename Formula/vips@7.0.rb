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
    rebuild 6
    sha256 cellar: :any,                 arm64_ventura:  "596f32a5e78707f36608d75d285e451d48e36c8d749a2cee24cbf0a9ffd527a9"
    sha256 cellar: :any,                 arm64_monterey: "f71f40fd287c74564e0582f5d4dc866eaacfb49348af60e9aec859988ffdae0e"
    sha256 cellar: :any,                 arm64_big_sur:  "12ce8608f4f42add8af90bdbfb12349be2da2b92bf3741ff25e1dc7d2335790b"
    sha256 cellar: :any,                 ventura:        "4e923dfc89f07ad4c35feb5ec56986c83f240411b2669e2c9086c5b24a538ca7"
    sha256 cellar: :any,                 monterey:       "8d4477062303c38f974987d4095bd1efe06dbc8be875136436628a8043855727"
    sha256 cellar: :any,                 big_sur:        "82f7a29221b564207828460ec2d117e6e3729fe10ddcc81b79b98a0ee22b4704"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31c80e7521f76644d5da766702d8950f404472bdd467514c8eaf58d723269c25"
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
