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

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "988d85b79cb0ceb6027f50ab7a51bc3ccbd301fa3b7a222596b1195e214a02f7"
    sha256 cellar: :any,                 arm64_sonoma:  "47014e0d4036d5aa4f7442d31341d1ab094322a4d2f74b6e6f21405552e5e35d"
    sha256 cellar: :any,                 arm64_ventura: "373326bc6c92ec1e07a5fa61c325acc41a6a8242c6dec4aa0e5bd021d72d1a02"
    sha256 cellar: :any,                 ventura:       "586bc9ebb2bc0afd0957cce1aad6ab5a395444e97b748330fd78e7665fa4d1ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7cc2d6bd162b4256afafce456748e03609329e3f0b04c3d212d4920772756feb"
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
