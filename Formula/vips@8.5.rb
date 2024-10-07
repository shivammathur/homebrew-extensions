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
    sha256 cellar: :any,                 arm64_sequoia: "f52a11529ccf2a2c96cb2000303cb439f40b8976e48836b34c39d4cbbcd66f2f"
    sha256 cellar: :any,                 arm64_sonoma:  "f2d119b921f2467dfb79a8f7116f4e11388cca02351d1c5893081bff4e3ca4e0"
    sha256 cellar: :any,                 arm64_ventura: "cbe78a02a7001a4a96137665d0f82f724b267d8c17817b91e4ca71a8b5c975c0"
    sha256 cellar: :any,                 ventura:       "261ab901f074c7a902d1bcae584cce532828c22e6dc5262150326cda161a7bde"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b44f3630edae3172aaad66f9e1ab0f81a4f7fbd8df954b9d128c72a51157197"
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
