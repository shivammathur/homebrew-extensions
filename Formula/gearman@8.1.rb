# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT81 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_ventura:  "62a0cb966949082bd159aff476194ea1f590802c47a5de7e6f0584b3b41c52a7"
    sha256 cellar: :any,                 arm64_monterey: "b42003556446dd73c0e03a249050aea77a201a476827b1b4d070e2a7dea44b4e"
    sha256 cellar: :any,                 arm64_big_sur:  "263ad5a1f0528cb78d7dfcd23d4fe5f3ac9fe44011d12ee437940c5979b3c6a8"
    sha256 cellar: :any,                 ventura:        "e79658f7cbc0b99c89564192759f838c8a31888a6f7ca54aee5578a1fba5db32"
    sha256 cellar: :any,                 monterey:       "c7b47fead94308b66f6203028324d07f0220d017dccd1bb7f9ac8e2cab1604a2"
    sha256 cellar: :any,                 big_sur:        "f66ca42dc85c08064e4e57b5efcf9f6b732f518d4df5082eb6701284b4675623"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "135e5c3037e6c6506d810ebe94710ace55f295a626232cad224eab98f0eee026"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    inreplace "php_gearman_worker.c", "ZVAL_NEW_ARR", "array_init"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
