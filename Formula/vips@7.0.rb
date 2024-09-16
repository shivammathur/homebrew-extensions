# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT70 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia:  "8f8af92108f19cde5e72d1f39a38cb24d4ce24cfc6a50a749cc91c89b17d3686"
    sha256 cellar: :any,                 arm64_sonoma:   "6775f52ecd3eb5b0b3b549a65789bba1dcc4d7a071d54d67376b6185abb7c20e"
    sha256 cellar: :any,                 arm64_ventura:  "d03b23991eca06f726fd435f26da05f5e852b1cff76a3579f72fe8589aa32dc6"
    sha256 cellar: :any,                 arm64_monterey: "14670ef4e7847df84c65207f4a53a5bb8dc1c84da102af474f7d9482c4edac50"
    sha256 cellar: :any,                 ventura:        "74652e2f2580bca9b3fa74e9277f4cf54560f91d60dfaa154d10d037058094ee"
    sha256 cellar: :any,                 monterey:       "bec904c54b45c1d7cd087094bb16fc0a068819b781383dd1daec8b00c1e0282d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1638d9b0a065df876e19ce09a67d2c7a719a0875f8369f2dd03e17a813533404"
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
