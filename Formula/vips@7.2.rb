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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "76504420fbb09c9a3ced66787a8fbff66b57c99fe19f0328d0c688e5b73667e8"
    sha256 cellar: :any,                 arm64_big_sur:  "282b583708599a8551bc102fe0e23556e9ad85b959539943acfa8e111e8646ed"
    sha256 cellar: :any,                 monterey:       "2b5904c9a1646c1012dc6ce9e2d3af5e3e53fd0220f984db4989ad55fb50b40b"
    sha256 cellar: :any,                 big_sur:        "af2a8d72dc1b510a715a957c9a2ea813aec19751c5dcf83d65c9ff700f713e79"
    sha256 cellar: :any,                 catalina:       "f313976e91ec4d69a7daa878f05768ea0fd940683bccc0bf8f85d9ba64387bd2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c35c3d579df00f3acfe7e2d3cf7b704f8e02e4c26b0bc23d5931da45f3263ef0"
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
