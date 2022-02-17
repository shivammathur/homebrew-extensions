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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "ff7e8d36afee256369bf8cd0d93c4c7f29b34fb61360196cce65322d8e4a3e3a"
    sha256 cellar: :any,                 big_sur:       "7d70ce543d4290fcd0a2648ae99ad43a864c65909f65a52bfbec1cf3db418964"
    sha256 cellar: :any,                 catalina:      "d0019ad8ecfbd3c2a7743690084316ddae872ebce1c5d3ee94250a6dff6d8a13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "08be1f584e708897ec218caff476f53a5d7a5390d8c39a2f72ec2ab41e7bed9f"
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
