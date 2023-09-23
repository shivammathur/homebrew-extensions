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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_ventura:  "8fd3efcf70c6c99e0ceb2414cda686d9fa6d3c55dc44085b0be790c3a3515b02"
    sha256 cellar: :any,                 arm64_monterey: "29176f0123d9c9308c582ae9fbf91d3bbfba06345ddf33ef47ca0fea64d9635d"
    sha256 cellar: :any,                 arm64_big_sur:  "100ffd3a0dd16d176ad1c827beffb40f05a97db0c3ea9875b34a2f1f734f8c89"
    sha256 cellar: :any,                 ventura:        "92ee9afa6ee3901871f3daf7125971500185903359e8a21d1effd6b00fb52e72"
    sha256 cellar: :any,                 monterey:       "174a936271caa81130f049899ca9955765643f44ab42b1505780548942066dbc"
    sha256 cellar: :any,                 big_sur:        "c576006b10c46fb795bbe67d555aa8c236825dfbe89291c0379aed3791e03413"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fe952c89acb12a91e142d32972f3a0b60ca1902e0f59c11e4394cddbbe85d31b"
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
