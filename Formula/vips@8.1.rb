# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT81 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/vips@8.1-1.0.13"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "49d647f60a7219c5b7566b276b3b594bea26eb8889510b7aa7059046deb70caa"
    sha256 cellar: :any,                 arm64_big_sur:  "25e68e1ce2acb48f3b89f6497adf12d67947c6c5833382d06a8d9de8163fb19b"
    sha256 cellar: :any,                 monterey:       "69f4e0a043f158552cd9ab0de4d3453c92958c37e88776c0075f281c5350ae63"
    sha256 cellar: :any,                 big_sur:        "57c818e1bfe153dde35e2eca753d524967dcf08446ab6934c53361b7130322b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "750a2573444e3a3ea542291ec0de84a9fc2a697e50b4d7c4258a790c5d2e416c"
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
