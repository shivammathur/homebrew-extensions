# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "e56f5b6c0eedb77d38254dd02b5823e8cdeef7820c5e6837a1b37c9e55feb4f8"
    sha256 cellar: :any,                 arm64_big_sur:  "6984a237ea705b42ce46cea1a12bf9474a6059743b2269bc686d2b9a55e8234c"
    sha256 cellar: :any,                 monterey:       "94e06dfc3a8d939a624598835882148d6b16cae448d099cc101e3e21b6d793a3"
    sha256 cellar: :any,                 big_sur:        "9b218e16fe35a948245f23c4ff45c04db01ccde798a0002357d95e8601b235bf"
    sha256 cellar: :any,                 catalina:       "71399c551f263b2d4f2791ff3203d63f56c7cf94d684d9bc4595b946452e07e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a1b6f470f062c62e8d54e8d27bb9ba233f3ba06c4b8b6ea7dedf6518e73288e0"
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
