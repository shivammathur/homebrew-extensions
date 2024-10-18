# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "c3c652122780dc0e2db8eb5ca6f42e674ea37984c4ac636940593fe05a4b3c81"
    sha256 cellar: :any,                 arm64_sonoma:  "e68edfd443b420fd5f27f7d9fc4e51ac13c9214df1c8faca0fbf15f875577caf"
    sha256 cellar: :any,                 arm64_ventura: "507d29860d0206bfdf6ff3dcfb5d750a321be2e8c04fa48dec3cc1118de7d41a"
    sha256 cellar: :any,                 ventura:       "1838da93f7e36e184b7df33ed058c5ca3182c08c70c6bbfcad4d77ef7ca145ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e68094f7b8ac3f947881c96387db32ba071de5076c7913871f22a1e2c5993a8c"
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
