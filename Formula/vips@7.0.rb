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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "2849c69968567803691d2d1550121659b46fe91a43343f5c945a4a122d3ae4ea"
    sha256 cellar: :any,                 arm64_big_sur:  "6d3c9f6371c801716445c0a915d51efea88cf6366f200eb8918032891f9b5d51"
    sha256 cellar: :any,                 monterey:       "1355c23f0cb43a96bc2726ebd7ef58690d5f8ec7c84c270ca3c3b488cc014cde"
    sha256 cellar: :any,                 big_sur:        "7f66cb7186e451f8b4b357f2d40d12976de31250f17b364e1cfa89d335bc12ad"
    sha256 cellar: :any,                 catalina:       "655e1825c7bcb404b3858346c454a38e28ff9e7297e06f432e0c6172f657c2f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "372af7576d7109bc3229572eb7be7e27edda3990b7ba9307f1b6eab19d28396c"
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
