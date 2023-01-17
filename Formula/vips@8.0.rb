# typed: false
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "63220a32ccb0bd5dbe99e6358c645d7b2de4a088cfeb1e6bd42597a11fa3fc4d"
    sha256 cellar: :any,                 arm64_big_sur:  "c3910e7d51c14af36ecc2454386b245a591ebeac651b091e15a8fa3fc7c1545e"
    sha256 cellar: :any,                 monterey:       "2cf58a7802a8e5a50bd71d8c69a77e3b3c7342a42fbedc71cf7264165a3c70a4"
    sha256 cellar: :any,                 big_sur:        "31db9b72c938411f0537ab8f3d559616d8a566d244818f07c257098d253acdf7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c6bab3591b5774081d67f17076c07a65e562831a70e0a72eebe3417f2741ab56"
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
