# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sequoia: "1f85ab5872c51a4d95c83a59818fcb4468461386ed79662a558038b88ae3ed27"
    sha256 cellar: :any,                 arm64_sonoma:  "d1e5f52b00b4cafee3c65dc685266a97baa0c4deee7d46dde2dd8da72e51564f"
    sha256 cellar: :any,                 arm64_ventura: "85cdbce26cdd20cd870d91a715d3552bc92850631b0e490afcce926dacb00079"
    sha256 cellar: :any,                 ventura:       "fdb4c5d4575b700b12a7803c6574ce5bccd5d60f0d8fefe993304031c76c69a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a9cd69a8202e3702eda08760d7266a5dbf8a936ca006226c0ddfbc0a9631345"
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
