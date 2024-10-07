# typed: true
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
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "8bef52f2ac9f52c05b1418a6793172cfeefd158bda315f9141048abc1cd75401"
    sha256 cellar: :any,                 arm64_sonoma:  "c45ab5d35b10c31b8686b778548187736aef66f8b54dfe4aaafd7516a9b0fdde"
    sha256 cellar: :any,                 arm64_ventura: "984dae573f3e4a3d1d65a061de48c482524c1821c6003ca251d35df37cb93ba4"
    sha256 cellar: :any,                 ventura:       "a2cdf51dd8e60188e75a3ddab482164c4595206f3184fb2692f774029265b04a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11ea8009a60bcc5d887673fc19813183ecbd04b7b2827c5ae5c3e4fd4005c570"
  end

  depends_on "gettext"
  depends_on "glib"
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
