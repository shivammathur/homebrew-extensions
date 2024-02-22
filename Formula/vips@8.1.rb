# typed: true
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
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "78d869a2c55a3129c4dff465dd699a10a86d634d1494cf0c8dfe0e8a0d375bd4"
    sha256 cellar: :any,                 arm64_ventura:  "40b88b26dbf03d88e73f2c6105d53663cf2df6965021d67a69ddb2d99fbbac4a"
    sha256 cellar: :any,                 arm64_monterey: "afadc785f9890a8f42563ae8c9d0c6a1d969a2fa38e3e852e6d36faa8e6f0a2f"
    sha256 cellar: :any,                 ventura:        "db5a876e0354da1237f088df8a06029094cacd498a95d114019bb87885a5c0d7"
    sha256 cellar: :any,                 monterey:       "db465f7219f889369f6a6832def88270fb7852ec4881ab1ef25dadcdf9ef8bea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "23383a50d484d81cd7d4db682ff7bdf025c02f0b79f66af82ea471491ecbfc9e"
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
