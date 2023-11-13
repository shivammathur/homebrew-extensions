# typed: true
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
    rebuild 7
    sha256 cellar: :any,                 arm64_ventura:  "deb4e37cb99ca2ab6e6651b7bac51f198ffe8f43bba85f260d8589e0832c7a24"
    sha256 cellar: :any,                 arm64_monterey: "d392be23bb0406ba89a7525c8278b826ce57a5f425bb8316d9d78943787ee3de"
    sha256 cellar: :any,                 arm64_big_sur:  "8bc6db62baf61a401f032929e7a501d54dd0e2784c645254935bc69ccf8c645f"
    sha256 cellar: :any,                 ventura:        "e229f372686404edc85cc9b916577d1a43e246d5703e4b8d621027703cd4bf67"
    sha256 cellar: :any,                 monterey:       "875f0d157abd5236fe1dc9021a290c76b00aebb58ebb34051353667a74f17171"
    sha256 cellar: :any,                 big_sur:        "3e805cef17595890347d0246cb82502dde09bdbc4eac484befd2781af2485199"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e4610114ef62db78ba5a36b32130f72524a378e540145a7729e5a1f59f13102b"
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
