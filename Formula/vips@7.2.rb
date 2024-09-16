# typed: true
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
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "3190ee034257a9fcbd83506028b87a273719adb55ad0e4a66de772a9825bb73f"
    sha256 cellar: :any,                 arm64_sonoma:   "a2a60051f72a168fc65b7202e45d19f7e2be16b6dd38214147c689f4e346c9d4"
    sha256 cellar: :any,                 arm64_ventura:  "4539ab60b9aff18719cab1dc1a43dbe45039b33ed89063de6488ec55076b9d8f"
    sha256 cellar: :any,                 arm64_monterey: "1ee2647f3538b2cdfcee4671298cccfcda9edba5160c077a3a79a6727018a46a"
    sha256 cellar: :any,                 ventura:        "7d31a351eab69d126f72ec2e7dd5dda226fd118be7365f971ae81ff1d0ac116d"
    sha256 cellar: :any,                 monterey:       "0b7d4db3364531ce20b17c7878c82bbaad908fc760b5888ca6657bf32828841e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fad80f842d824dfabd37d4afc3ae49013135aec13f122d9f7fb27c85c3c75092"
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
