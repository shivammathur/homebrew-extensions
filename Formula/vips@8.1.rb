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
  revision 1
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4212cd121874df90be039958c1a239c991f3ff06a441093036506e2972c1ddc6"
    sha256 cellar: :any,                 arm64_sequoia: "bca3d7f6c1076c7119b88740a8afb168f3e4465e2de8ff710ead85a1f65cdc2a"
    sha256 cellar: :any,                 arm64_sonoma:  "4973812409e2f3b3abe4aad10f72460bc413d8acffc485a38d0901fa5b13dbc6"
    sha256 cellar: :any,                 sonoma:        "a8368359e967b01e54fcf49f35cd9eea1485ddccf19c4fde508df5a98c80f931"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "61657e74ec579e563a43cc0c33046b50e4aeb680ff0ae4f74c2c34dac12baec0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff3a17726dd8614f87c0ddc8b1810b7c3d9dbe8612a722b2e0c79da513b6e32a"
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
