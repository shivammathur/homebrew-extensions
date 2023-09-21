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
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "720e4d72b56704299ccee703c3424bd9391d9cc3bcf102af15881d0cc4f446af"
    sha256 cellar: :any,                 arm64_monterey: "09114e32e69983ed76acefd7c7215540a42611966fd2634d260a51bd5459d868"
    sha256 cellar: :any,                 arm64_big_sur:  "d08043a8bbc05f0b75d131431911aa5ecc7a07a418c05ddf7c3681b5110a2409"
    sha256 cellar: :any,                 ventura:        "4092f83365ff69c1e6e94a2bd35f5187fac814857944ddfecd77ad33a49d2b6a"
    sha256 cellar: :any,                 monterey:       "1360e7ab7eac2ef30cd6ad18471a19bcdff8b7c0864651b8c4fd49559e85334e"
    sha256 cellar: :any,                 big_sur:        "abb2b42598c9605629fb9fe1dd17aceebcdf9be4625a27737db38e5c10bfc524"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "093506fb119e72d13488eb740f88b2fe1a12b555747fc5932773a8e6378dc829"
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
