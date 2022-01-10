# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT72 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.12.tgz"
  sha256 "c638250de6cad89d8648bff972af5224316ccb5b5b0a7c9201607709d5385282"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "5a9097d19f6865014669255d134e4b6e7458dcf611a220b3e7dbc30dcc7e5ebb"
    sha256 cellar: :any,                 big_sur:       "b19e20b8225bbd80788b8c33f3a9e90cacdeac5b15c974a53f3a4b37cc95a0fd"
    sha256 cellar: :any,                 catalina:      "ff104e5d5d76cce7eb544646d66d23c52c323c05058155e68ee1314ce636d151"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e3553c9589efef2a58b299f07a830d6c47ea28849e9ef51ac1899384e9cd33b4"
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
