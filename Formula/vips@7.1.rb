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
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia:  "0994648585a01ddae8a661a59d208f059d6332eff741e222b6b0b1994c124ba1"
    sha256 cellar: :any,                 arm64_sonoma:   "41de12191a20ab63a6db09c87dfb29747bc37763791717e8574e79383c9b2e29"
    sha256 cellar: :any,                 arm64_ventura:  "011901b751785097775b986241528e7bb076a3f5ca98d7dce59093e64a79ac2b"
    sha256 cellar: :any,                 arm64_monterey: "cf53ddcf4bed0c0d52e59a0d905fcdd1642a8df77a9570363b5ab946043655cc"
    sha256 cellar: :any,                 ventura:        "0c5379988bca23fcec6a5a137c79e2664bca615c1274013dd2a55666d74e4ec9"
    sha256 cellar: :any,                 monterey:       "5e1dfe95bf8df30f803695768ab8116979caedfbc3541d20e0da69ed64259c81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "89b5524ab394393abb6d5fd098378034a522e58eb049864df8845ded0f285919"
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
