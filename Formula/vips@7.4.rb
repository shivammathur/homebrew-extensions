# typed: true
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
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "0fac34ea3e6e3b8bcca5840fc91bc8be59529999653b8486d0dd5727935e4fb4"
    sha256 cellar: :any,                 arm64_ventura:  "8a0aefcf97cc506e2b7c3bb410a7649d4daeab6c20dc01988ab56a7c0e0ee2cc"
    sha256 cellar: :any,                 arm64_monterey: "0ff652b0ad187bca93fa82a44839086f4be3af395df4efcbdd3d21db4494dc43"
    sha256 cellar: :any,                 ventura:        "e3053b8ab25092da1c0c1d3655c0afb2b89518078b68c8a3a0065b2cf5025809"
    sha256 cellar: :any,                 monterey:       "d104ed353f5135b498be5083554636e3b836a6e0105156f628e0e2f6ff216896"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fda9850a9167436c579e1b40ffea103d349839adb10457b237910328feff7eb4"
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
