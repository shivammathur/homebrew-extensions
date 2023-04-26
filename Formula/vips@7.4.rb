# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "b8c604b2d2e5e743a9818883a7b7c6f032993d6136381da47ffecedcc85371a4"
    sha256 cellar: :any,                 arm64_big_sur:  "67742abb1f486272194650559427c493f5cff3ca4c5aba98e4afe827c52f12a6"
    sha256 cellar: :any,                 ventura:        "797b2e1c9ea0a82732f7ddbd1fb41c52753b632240f6558e77609db359558271"
    sha256 cellar: :any,                 monterey:       "a2cad5543f713b289ed1a7d2e81225fd0e270f7439b20dd8003692cf1b799b92"
    sha256 cellar: :any,                 big_sur:        "53a13513d5022ceeea2123ee92662bde04801a55e1e2fc3ee8597c5c8e29b4cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c3af909c86d21316377d86c3f9c4b217cf0dbad4de394e817bde08392c556b2a"
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
