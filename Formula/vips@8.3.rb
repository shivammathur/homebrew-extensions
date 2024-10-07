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
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia:  "aaf4cbb192ac3f39aa609d8d1f4fa35ea211a6c644595f2bf6aa229a07cc02b8"
    sha256 cellar: :any,                 arm64_sonoma:   "3b813838348dde49b2db852e1968004c36b070c90ec67dc49339e02dffaf11dd"
    sha256 cellar: :any,                 arm64_ventura:  "58922442d0ad52f3977ecdc0433ff659e06727077803ccb908fb33943e4ef722"
    sha256 cellar: :any,                 arm64_monterey: "79df37536551f6ccfc48e298cec8f44a980c1b002e9b933a6ca1f29c5f3cb41c"
    sha256 cellar: :any,                 ventura:        "dcec5b0e83591d5a9d86911d6f7bbed9f19483f0441dc0e907dc2f75fc4e7e07"
    sha256 cellar: :any,                 monterey:       "017f90aca0422de8aa553d25db9f73e0dd1e19227b5c21c188526f3bf2b26ea1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "245177f05cb65850f6b1a8a768014813ca7d3f80df99642feb4b463b3f8029df"
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
