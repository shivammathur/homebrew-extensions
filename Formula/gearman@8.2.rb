# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT82 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "6c523330f35cef91857407f66f12393dc58ce368e228e8cc16bb8eb94f321da5"
    sha256 cellar: :any,                 arm64_big_sur:  "83b30779ebdc0cbb349f5b155ff66fa42e962360d56b6f59d70aa2599ec8e9d8"
    sha256 cellar: :any,                 monterey:       "6ec03b9681471cfd1ac98a3f0bb3c2d8e59ce52983d5957d8aaadff2b93e36b7"
    sha256 cellar: :any,                 big_sur:        "445bb64d5a44015d6badbccc5e541083037e5571103d09bd45754d7270db87bb"
    sha256 cellar: :any,                 catalina:       "3d8134e1f9af1884c0518e3bd77d0fb52ba88111565ddd0f90fec2b95d607b37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8c4c4964526cf343b87603493f3734609fcd5eb6d0a9771ce20c11f6b82d0042"
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
