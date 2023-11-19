# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT80 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "5182cab429dcabce1f23d762bf4f9f572a1981b7c476b52227ca146df8019d86"
    sha256 cellar: :any,                 arm64_ventura:  "116250504d086bbc1f953bb34659c76a9e34b7a5d5d323dc0d84ee3d777dc192"
    sha256 cellar: :any,                 arm64_monterey: "720109ffff09581f9c18c50d1e34458ba8258f608744de5babfaba110a24b199"
    sha256 cellar: :any,                 ventura:        "7d17a0b04917d9679aecd9cec1437fdfb2021d1b68fe2d8a198b35dca95f4632"
    sha256 cellar: :any,                 monterey:       "b7e0554a0aacb2b52b0afdd13cabd21aad2c7c9653c0abf7aec70ff16560fa24"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e59dffba025ba1a7f251eb4e596cc1c8fb7bcb19c0e135ded08d3b2b66f4b367"
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
