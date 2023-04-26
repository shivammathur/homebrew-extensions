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
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "912ec1628c7f671081b6db4b79a2fb63d449c20045911b4d0c253b3c7428bd83"
    sha256 cellar: :any,                 arm64_big_sur:  "c11d6998b326b7aca4103eaaf34efa787079da0e7ed8873d68746c419db8dbca"
    sha256 cellar: :any,                 ventura:        "f71f03232c4f165e70260a4afda3b04a5c36511ec09e7f1dcb4bbaec4248017a"
    sha256 cellar: :any,                 monterey:       "75efe002c3f14d66500b436edb7d32b94231eae3f7417cd608ab9665f04518b2"
    sha256 cellar: :any,                 big_sur:        "15d8e89e94d3d0c1b2d6358d83a53fa4e7b8b4bbab07e0ca5c5d5a886ded13ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6497b89c1a69af820cb3702c81c665f86bd4a8439c6bd48cf2ef99c172579547"
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
