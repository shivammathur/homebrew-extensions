# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia:  "d89f7f0d6ebf13cc8d9d81ab863892970484d4f0bb9f55f28f36719de8fa0ed4"
    sha256 cellar: :any,                 arm64_sonoma:   "064f1ea95d4e94ebca6a1786f97b32322059845cdbe3e5cccc03acad7f81ca1e"
    sha256 cellar: :any,                 arm64_ventura:  "e836a3c440c37eb53fee318d9d40fad6916b96e644b6886461f7e8ab02679baf"
    sha256 cellar: :any,                 arm64_monterey: "110e06c051ab9b76d066a4dcd0bcd52ed9b15890e00ff8948d86cb2d3b27893b"
    sha256 cellar: :any,                 ventura:        "b04cf2f059138c1d4d68d2d72476dd0999542b2fb1f96b1b7af41b5e49a3e715"
    sha256 cellar: :any,                 monterey:       "c09cf62bdb3707b2280af4948bb50884f39d0fff17a8d267859552b92f2246ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d62df3e498a393f2fb6c76e274bbdf44c682e92f4aa61ef7a0589bd437ae9c4c"
  end

  depends_on "gettext"
  depends_on "glib"
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
