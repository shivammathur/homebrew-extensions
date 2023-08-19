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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "a1d10e9f0b43ed3123c1b990cc78dffe5702f161bbd677debe8ebf72ea43ebe1"
    sha256 cellar: :any,                 arm64_big_sur:  "4c2c6e7156c0c27dbd6aacaca07c31f668ff4c8d17c010e3a1c623c998332380"
    sha256 cellar: :any,                 ventura:        "1906e6e380febf90568ab1ae53b6c2d9696888f90bc76f522e54bcf11b9e6495"
    sha256 cellar: :any,                 monterey:       "a5f783e825c9e5982311f58d30c31d6b80b99164e7473f3ac987abbd0280a51e"
    sha256 cellar: :any,                 big_sur:        "e2b422a773eae084b2c3409d983958bd4f5513d7f111491b819d3c4790279d25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ee0fe7451d9dc2cc597d137c7f4c44122a6e30dd603d60ddf9c305698e22b066"
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
