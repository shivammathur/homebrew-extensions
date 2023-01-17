# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT80 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "26c6e57eee669dd1f63d50eb9be7f340fe19fa6ccda439de834984ca5334a8fc"
    sha256 cellar: :any,                 arm64_big_sur:  "982a5405cb2a2a8b99d52ab07a7b3809ad9c295e5c79e8b56feeb2a90cfa45e4"
    sha256 cellar: :any,                 monterey:       "ca99af219e2a8b9350a6dc7fd4ee2f5baec931384217f3dfc45d15cedfb0e3ae"
    sha256 cellar: :any,                 big_sur:        "9555abfa2e9a9f176528440891a86a4abc9f48f494d61a5272cc1a552a567d06"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4fc688cb93411af9e17b410989f552ede67fa2e1e65cdb4adc2d4581802d377e"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
