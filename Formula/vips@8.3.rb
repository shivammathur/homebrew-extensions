# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sequoia: "0879c750816ecb8045f9ae26ce82a01c9605f278142f3cfd6bd9e4aa219e1026"
    sha256 cellar: :any,                 arm64_sonoma:  "04a8cdbadc0c4a7a2830569f0ac4369cea20afc050121e83da3047645d4fdd94"
    sha256 cellar: :any,                 arm64_ventura: "4bb5c6e33ec602b118cb2b27d9c012b34e8be844d98690d313b7cd86fc0f62c0"
    sha256 cellar: :any,                 ventura:       "8b9d70eef17501802d5cfea5d5a905b7cec2b2aee19fba96effa374d77971143"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "20e029d5c10e24cd7a8300e3f4f8e83e9ffe704c0b7355b58751373c9a9fe4f8"
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
