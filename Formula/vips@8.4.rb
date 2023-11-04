# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT84 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "6ce6f2296ee27a16565fe86e7cdcb8bc315684320aeec29708a7bba877a06824"
    sha256 cellar: :any,                 arm64_ventura:  "1d77f09378aed0e9d43ebf62371c4664fa3a3d692c2ec49ce9d866a42dd7cc2c"
    sha256 cellar: :any,                 arm64_monterey: "df4bce6e593ebc77f975538ecc230d1c8458d6db3049d90d02204bc966545359"
    sha256 cellar: :any,                 ventura:        "9c0fa8b4e4f137e81d5ced6d8f6d4333c0460fc5f993789aad2052c09bfa70db"
    sha256 cellar: :any,                 monterey:       "406db6205a60b4241115c0b62219a942e4cca65fcad06878739289bd8320262a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7106a36bc7a28b02a7427d3c29aba319580107fbf6b8704c02cbfa71b76321d"
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
