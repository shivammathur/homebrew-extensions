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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "d84e25a688d7cf32dbd34e9f7c34e17f84d3a0667abb2979b47fa3759bc8828d"
    sha256 cellar: :any,                 arm64_big_sur:  "fe90642bd2af9c627b031f3a3ad7e39b380d722ffb4d143eec927088d13453df"
    sha256 cellar: :any,                 monterey:       "0e2a06761cb0f1a09bc4f9e06569630e413a68ebda0605e0be92a114784c593c"
    sha256 cellar: :any,                 big_sur:        "5500ba620936020c7fd1fe221dd167a7d0547ba1955d001e608664b44e527f60"
    sha256 cellar: :any,                 catalina:       "351be67426d96fec5818af3d6102be108d3eff1061f93083b57818fc65b28886"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7efdd30b305ffa4bb2c1d335edbe4e5827fac6c0977e9d8f3f006361ac4b6478"
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
