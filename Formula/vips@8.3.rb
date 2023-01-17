# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/vips@8.3-1.0.13"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "2485964f5042deeb23199cdc5a6454a44394b1e9cd4d90e04975e5b3b997be9e"
    sha256 cellar: :any,                 arm64_big_sur:  "997e0055b6e764ce0feaefebfb0f8369866e995c63ce268621ff5b73cba3e984"
    sha256 cellar: :any,                 monterey:       "78b1f8459f78c722c29b0db2b99369a11a72b98efa55509aa84047a14991ae65"
    sha256 cellar: :any,                 big_sur:        "a30b5a32b8a2222ba792964fafc3eff0c2d5d4eed88f0ac316d856390f99a23d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "85352401d86522a01614d7d40fd37a81e0ca0ea47925445285a2e07e889c9f8a"
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
