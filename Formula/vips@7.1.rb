# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "6aea50af7d422e25547201058e1109579365f19c2e6ea73b9bf302fb38d534cd"
    sha256 cellar: :any,                 arm64_sonoma:  "a3afa98e213def2d680c6ceb6f703755c282515ed3ea4ad1ed338e8f03766433"
    sha256 cellar: :any,                 arm64_ventura: "cc93b2eed7f6570f2d357a6a05a882fe959dbbbd77296a4e09baf1a38cb978b2"
    sha256 cellar: :any,                 ventura:       "b8cacd527748a88e2f53f905eccf36d81852f0069b92781bd266f843c15e9943"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3fd4de3de14f92ac2b1b07c640bc1ecd37e66d8d760256e8659b3611524943c4"
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
