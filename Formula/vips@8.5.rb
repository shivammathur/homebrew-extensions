# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "9fdf4c6b8a07c3b0ae17a59eafe1a72fd37388bc1301282f6d53868bebe7af5e"
    sha256 cellar: :any,                 arm64_sonoma:  "33b79bc2e8c7cd24a19d0b293bae1fa7dc415a952378332852e32c76fa9c1916"
    sha256 cellar: :any,                 arm64_ventura: "4e886f0e0f3d9bcd1ffb9af153080ff7beb2b22fa4ab4856d1af5a8733273490"
    sha256 cellar: :any,                 ventura:       "fe3a87c64c807d7d685bdc05a1cbb618c42899f680ea657f84da1e57e3d86353"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0b9ba1db1ae65d673cd643a36c62e48fdd0197fadc9000bbec129a637c7ea64c"
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
