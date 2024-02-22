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
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "07652c83d25ab4a948e496841b070aafcdd6411430c3e5dee6a7c7d6c76656f4"
    sha256 cellar: :any,                 arm64_ventura:  "390f67617cc03f36cc475a595a606581917c14bb7a92cf83c1c941b93bdf12c7"
    sha256 cellar: :any,                 arm64_monterey: "d2b096e53e169f2ee8c5fe7d6d576b5e9c230905833709cb5df161f074268e9d"
    sha256 cellar: :any,                 ventura:        "1b89daf9ea47df120ae04d9c9ab81462ece84282fe1d918e0ed05f799d2f75b6"
    sha256 cellar: :any,                 monterey:       "d412f62b699624a1b14a7fa0d4d33168cde1e622c238eb6859ac5478f430d4e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4f45d71cc27f63e02f4515d46c05e2372600205907a55a83a5885f22cfa844a9"
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
